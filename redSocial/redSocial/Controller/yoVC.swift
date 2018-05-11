//
//  yoVC.swift
//  redSocial
//
//  Created by misael rivera on 05/03/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import  GoogleSignIn

class yoVC: UIViewController {
    
    @IBOutlet weak var mefoto: UIImageView!
    @IBOutlet weak var meCorreoLbl: UILabel!
    
    var handle:DatabaseHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mefoto.layer.cornerRadius = self.mefoto.frame.size.width / 2
        mefoto.clipsToBounds = true
        let userID = Auth.auth().currentUser?.uid
        print("susurio ID"+userID!)
        DataService.instance.REF_BASE.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let nombre = value?["nombre"] as? String
            let urlFoto = value?["foto"] as? String
            let user = yoDatos(nombre: nombre!, foto: urlFoto!)
            self.meCorreoLbl.text = user.nombre
            // self.meCorreoLbl.text = username
            if urlFoto?.isEmpty == false {
                Storage.storage().reference(forURL: urlFoto!).getData(maxSize: 10 * 1024 * 1024, completion: { (data, error) in
                    if let error = error?.localizedDescription {
                        print("error al traer imagen", error)
                        self.mefoto.image  = #imageLiteral(resourceName: "defaultProfileImage")
                    }
                    else { self.mefoto.image = UIImage(data: data!) }
                })
            }
            else {
                self.mefoto.image  = #imageLiteral(resourceName: "defaultProfileImage")
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    @IBAction func logOutBtnWasPressed(_ sender: Any) {
        let alerta = UIAlertController(title: "Estas seguro?", message: "estas apunto de cerrar sesion", preferredStyle: .alert)
        let alertaAcion = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default) { (alerta) in
            try! Auth.auth().signOut()
             GIDSignIn.sharedInstance().signOut()
            let authVC = self.storyboard?.instantiateViewController(withIdentifier: "authVC")
            //inicioVC
            self.present(authVC!, animated: true, completion: nil)
        }
        let alertaAcion2 = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alerta.addAction(alertaAcion)
        alerta.addAction(alertaAcion2)
        present(alerta, animated: true)
    }
}
