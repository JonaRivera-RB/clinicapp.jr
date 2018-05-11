//
//  clinicaVC.swift
//  redSocial
//
//  Created by misael rivera on 22/03/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class clinicaVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
private (set) public var clinicasMostrar = [clinicas]()
    var nombre = ""
    var direccion = ""
    var telefono = ""
    var urlfoto = ""
    var idClinica = ""
    var listaReviews = [reviews]()
    
    @IBOutlet weak var nombreTxt: UILabel!
    @IBOutlet weak var telefonoTxt: UIButton!
    @IBOutlet weak var direccionTextBtn: UIButton!
    @IBOutlet weak var fotoImage: UIImageView!
    @IBOutlet weak var tablaReviews: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablaReviews.delegate = self
        tablaReviews.dataSource = self
        traerDatosClinica()
        traerReviews()
    }
    func traerReviews()
    {
        DataService.instance.REF_BASE.child("reviews").observe(DataEventType.value) { (snapshot) in
            self.listaReviews.removeAll()
            for item in snapshot.children.allObjects as! [DataSnapshot]
            {
                if let valores = item.value as? [String:AnyObject]
                {
                    let nombre = valores["nombre"] as! String
                    let review = valores["review"] as! String
                    let idReview = valores["idClinica"] as! String
                   // let valoracion = valores["valoracion"] as! String
                    if idReview == self.idClinica {
                let reviewss = reviews(nombreAutor: nombre, fechaReview: "hace un dia", reviewDice: review)
                        self.listaReviews.append(reviewss)
                    }
                }
            }
            self.tablaReviews.reloadData()
        }
    }
    func traerDatosClinica()
    {
        nombreTxt.text = nombre
        telefonoTxt.setTitle(telefono, for: UIControlState.normal)
        direccionTextBtn.setTitle(direccion, for: UIControlState.normal)
        if urlfoto != "" {
            Storage.storage().reference(forURL: urlfoto).getData(maxSize: 10 * 1024 * 1024, completion: { (data, error) in
                if let error = error?.localizedDescription {
                    print("error al traer imagen", error)
                }
                else
                {
                    self.fotoImage.image = UIImage(data: data!)
                }
            })
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablaReviews.dequeueReusableCell(withIdentifier: "cellReviews") as? reviewCell
        let revi = listaReviews[indexPath.row]
        cell?.actualizarVista(reviews: revi)
        return cell!
    }
    
    
    @IBAction func reviewBtn(_ sender: Any) {
        performSegue(withIdentifier: "reviewSg", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let reviewVC = segue.destination as? reviewVC {
            reviewVC.initReview(id:idClinica)
        }
        else if let especialidades = segue.destination as? especialidades {
            especialidades.initReview(id: idClinica, clinicaNombre: nombre)
        }
        else if let especialidad = segue.destination as? especialidadesVC {
            especialidad.initNombreClinica(nombre: nombre, idClinica: idClinica)
        }
    }
    func initClinicas(clinica: clinicas)
    {
        nombre = clinica.nombre
        direccion = clinica.direccion
        telefono = clinica.telefono
        urlfoto = clinica.foto
        idClinica = clinica.id
        print("estoy dentro\(idClinica)")
    }
    
    @IBAction func cerrarBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func agregarBTn(_ sender: Any) {
        performSegue(withIdentifier: "especialidad", sender: self)
    }
    
    @IBAction func nomstrarEspecialidadesBtn(_ sender: Any) {
        performSegue(withIdentifier: "especialidadesSegue", sender: self)
    }
}
