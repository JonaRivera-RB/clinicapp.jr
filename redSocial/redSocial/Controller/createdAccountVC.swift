//
//  createdAccountVC.swift
//  redSocial
//
//  Created by misael rivera on 03/03/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class createdAccountVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var correoTxt: InsertTextField!
    @IBOutlet weak var passwordTxt: InsertTextField!
    @IBOutlet weak var nombreTxt: InsertTextField!
    @IBOutlet weak var imagenViewProfile: UIImageView!
    
    var imagen = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagenViewProfile.layer.cornerRadius = self.imagenViewProfile.frame.size.width / 2
        imagenViewProfile.clipsToBounds = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(createdAccountVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func createdAccountBtn(_ sender: Any) {
        if correoTxt.text != nil &&  passwordTxt.text != nil && nombreTxt.text != nil {
            registerUser(with: self.correoTxt.text!, andPassword: self.passwordTxt.text!, userCreationComplete: { (success, registrationError) in
                if success {
                    print("Registrado exitosamente")
                } else {
                    print(String(describing:registrationError?.localizedDescription))
                }
            })
        }

    }
    func registerUser(with email:String, andPassword password:String, userCreationComplete:@escaping(_ status:Bool, _ error:Error?) -> () ) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                userCreationComplete(false, error)
                return
            }
            let storage = Storage.storage().reference()
            let nombreImagen = UUID()
            let directorio = storage.child("imagenesUsuarios/\(nombreImagen)")
            let metaDatos = StorageMetadata()
            metaDatos.contentType = "image/png"
            directorio.putData(UIImagePNGRepresentation(self.imagen)!, metadata: metaDatos, completion: { (data, error) in
                if error == nil
                {
                    print("cargo la imagen")
                    AuthService.instance.loginUser(with: self.correoTxt.text!, andPassword: self.passwordTxt.text!, loginComplete: { (success, nil) in
                        let inicioVC = self.storyboard?.instantiateViewController(withIdentifier: "inicioVC")
                        //inicioVC
                        self.present(inicioVC!, animated: true, completion: nil)
                        print("registrado exitosamente")
                    })
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
            let userData = ["nombre": self.nombreTxt.text!,
                            "email": user.email,
                            "contraseña": self.passwordTxt.text!,
                            "id": user.uid,
                            "foto":String(describing:directorio)]
            DataService.instance.createDBUser(uid: user.uid, userData: userData as Any as! Dictionary<String, Any>)
            userCreationComplete(true, nil)
        }
    }
    
    @IBAction func changuePhotoWasPressed(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker,animated: true,completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imagenTomada = info[UIImagePickerControllerEditedImage] as? UIImage
        imagen = imagenTomada!
        imagenViewProfile.image = imagenTomada
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
