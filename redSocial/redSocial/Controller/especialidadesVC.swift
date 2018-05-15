//
//  especialidadesVC.swift
//  redSocial
//
//  Created by misael rivera on 02/05/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class especialidadesVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
 

    @IBOutlet weak var especialidadesTableView:UITableView!
    
    var nombreClinica: String!
    var idClinica: String!
    var listaEspecialidades = [especialidad]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        especialidadesTableView.delegate = self
        especialidadesTableView.dataSource = self
        print(nombreClinica!)
        DataService.instance.REF_BASE.child("especialidades").child(nombreClinica).observe(DataEventType.value) { (snapshot) in
            self.listaEspecialidades.removeAll()
            print("estoy aqui 1")
            for item in snapshot.children.allObjects as! [DataSnapshot]
            {
                print("estoy aqui 2")
                if let valores = item.value as? [String:AnyObject] {
                    let nombre = valores["especialidad"] as! String
                    let idClinicaa = valores["idClinica"] as! String
                    let idEspecialidad = valores["idEspecialidad"] as! String
                    print("id clinica\(self.idClinica)idEspecialidadClinica\(idClinicaa) idESpecialidad\(idEspecialidad)")
                    if idClinicaa == self.idClinica {
                        let especialidadess = especialidad(especialidadNombre: nombre, idEspecialidad: idEspecialidad)
                        print("especialidades->",especialidadess)
                        self.listaEspecialidades.append(especialidadess)
                    }
                }
            }
            self.especialidadesTableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaEspecialidades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = especialidadesTableView.dequeueReusableCell(withIdentifier: "cellEspecialidades") as? especialidadesCell
        let especi = listaEspecialidades[indexPath.row]
        cell?.actualizarVista(especialidades: especi)
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let especialidad = listaEspecialidades[indexPath.row]
        performSegue(withIdentifier: "doctoresVC", sender: especialidad)

         }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let doctoresvc = segue.destination as? doctoresVC {
            doctoresvc.initEspecialidades(especialidades: sender as! especialidad)
        }
    }
    func initNombreClinica(nombre:String,idClinica:String)
    {
        nombreClinica = nombre
        self.idClinica = idClinica
    }
    
    @IBAction func regresarBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
