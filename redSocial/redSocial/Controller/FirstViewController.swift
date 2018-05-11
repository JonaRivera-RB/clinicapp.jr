//
//  FirstViewController.swift
//  redSocial
//
//  Created by misael rivera on 03/03/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imagenView: UIImageView!
    @IBOutlet weak var nombreTxt: UITextField!
    @IBOutlet weak var direccionTxt: UITextField!
    @IBOutlet weak var telefonoTxt: UITextField!
    @IBOutlet weak var esconderView: UIView!
    @IBOutlet weak var tablaClinicas:UITableView!
    
    var imagen = UIImage()
    var listasClinicas = [clinicas]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tablaClinicas.delegate = self
        tablaClinicas.dataSource = self
        DataService.instance.REF_BASE.child("clinicas").observe(DataEventType.value) { (snapshot2) in
            self.listasClinicas.removeAll()
            for item in snapshot2.children.allObjects as! [DataSnapshot]
            {
                if let valores = item.value as? [String:AnyObject] {
                    let direccion = valores["Direccion"] as! String
                    let nombre = valores["nombre"] as! String
                    let id = valores["id"] as! String
                    let urlImagen = valores["foto"] as! String
                    let telefono = valores["Telefono"] as! String
                let clinica = clinicas(nombre: nombre, direccion: direccion, telefono: telefono, foto: urlImagen, id: id)
                self.listasClinicas.append(clinica)
            }
            }
            self.tablaClinicas.reloadData()
        }
    }
    @IBAction func nuevoBtnFuePresionad(_ sender: Any)
    {
        esconderView.isHidden = false
    }
    @IBAction func guardarBtn(_ sender: Any) {
        let id = DB_BASE.childByAutoId().key
        let storage = Storage.storage().reference()
        let nombreImagen = UUID()
        let directorio = storage.child("imagenesClinicas/\(nombreImagen)")
        let metaDatos = StorageMetadata()
        metaDatos.contentType = "image/png"
        directorio.putData(UIImagePNGRepresentation(imagen)!, metadata: metaDatos, completion: { (data, error) in
            if error == nil
            {
                print("cargo la imagen")
            }
            else
            {
                if let error = error?.localizedDescription {
                    print("error de firebase",error)
                }
                else {
                    print("error de codigo")
                }
            }
        })
        let clinicaDatos = ["nombre":nombreTxt.text!,
                            "Direccion":direccionTxt.text!,
                            "Telefono":telefonoTxt.text!,
                            "id":id,
                            "foto": String(describing:directorio)]
        DataService.instance.createClinicas(uid: id, clinicaDatos: clinicaDatos)
        esconderView.isHidden = true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listasClinicas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablaClinicas.dequeueReusableCell(withIdentifier: "cellClinicas") as? clinicasCell
        let clinica = listasClinicas[indexPath.row]
        cell?.actualizarVista(clinica: clinica)
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let clinicaMostrar = listasClinicas[indexPath.row]
        performSegue(withIdentifier: "clinicasVCm", sender: clinicaMostrar)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let clinicaVC = segue.destination as? clinicaVC {
            assert(sender as? clinicas != nil)
            clinicaVC.initClinicas(clinica: sender as! clinicas)
        }
    }
    //pedir permiso para acceder a biblioteca
    @IBAction func cambiarImagenBtn(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker,animated: true,completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imagenTomada = info[UIImagePickerControllerEditedImage] as? UIImage
        imagen = imagenTomada!
        imagenView.image = imagenTomada
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

