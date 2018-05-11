//
//  AuthVC.swift
//  redSocial
//
//  Created by misael rivera on 03/03/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase

class AuthVC: UIViewController,UIGestureRecognizerDelegate,GIDSignInUIDelegate,GIDSignInDelegate{

    @IBOutlet weak var emailField: InsertTextField!
    @IBOutlet weak var passwordField: InsertTextField!
    
    var name:String!
    var email:String!
    var image:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self

        dismissOnTap()
    }
        func dismissOnTap() {
            self.view.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(AuthVC.dismissKeyboard))
            tap.delegate = self
            tap.cancelsTouchesInView = false
            self.view.addGestureRecognizer(tap)
        }
        
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
            if touch.view is GIDSignInButton {
                return false
            }
            return true
        }
        
        @objc func dismissKeyboard() {
            self.view.endEditing(true)
        }
       /* let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AuthVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }*/
    @IBAction func signInWithEmailBtnWasPressed(_ sender: Any) {
        if emailField.text != nil &&  passwordField.text != nil {
            AuthService.instance.loginUser(with: emailField.text!, andPassword: passwordField.text!, loginComplete: { (success, loginError) in
                if success {
                    let inicioVC = self.storyboard?.instantiateViewController(withIdentifier: "inicioVC")
                    //inicioVC
                    self.present(inicioVC!, animated: true, completion: nil)
                } else {
                    print(String(describing: loginError?.localizedDescription))
                }
            })
        }
    }
    
    @IBAction func createdAccountVC(_ sender: Any) {
        let createdAccountVC = storyboard?.instantiateViewController(withIdentifier: "createdAccountVC")
        present(createdAccountVC!, animated: true, completion: nil)
    }
    
    //google login
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let err = error{
            print("failed to log into google: ",err)
            return
        }
        
        guard let idToken = user.authentication.idToken else {return}
        guard let accessToken = user.authentication.accessToken else {return}
        guard let imagen = user.profile.imageURL(withDimension: 400) else {return}
        let url = imagen
        
        if let dataa = try? Data(contentsOf: url)
        {
         image = UIImage(data: dataa)!
        }
        let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        Auth.auth().signIn(with: credentials) { (user, error) in
            if let erro = error{
                print("error",erro)
                return
            }
            guard let uid = user?.uid else {return}
            DataService.instance.REF_USERS.child((user?.uid)!).observeSingleEvent(of: .value, with: { (snaps) in
                let snaps = snaps.value as? NSDictionary
                if(snaps == nil)
                {
                   // let imagenString  = String(describing:self.image)
                    let storage = Storage.storage().reference()
                    let nombreImagen = UUID()
                    let directorio = storage.child("imagenesUsuarios/\(nombreImagen)")
                    let metaDatos = StorageMetadata()
                    metaDatos.contentType = "image/png"
                    directorio.putData(UIImagePNGRepresentation(self.image)!, metadata: metaDatos, completion: { (data, error) in
                        if error == nil
                        {
                            DataService.instance.REF_USERS.child((user?.uid)!).child("nombre").setValue(user?.displayName)
                            DataService.instance.REF_USERS.child((user?.uid)!).child("email").setValue(user?.email)
                            DataService.instance.REF_USERS.child((user?.uid)!).child("foto").setValue(String(describing: self.image))
                            let userData = ["nombre": user?.displayName,
                                            "email": user?.email,
                                            "id": user?.uid,
                                            "foto":String(describing:directorio)]
                            DataService.instance.createDBUser(uid: user!.uid, userData: userData as Any as! Dictionary<String, Any>)
                        }
                        if let error = error?.localizedDescription {
                            print("error de firebase",error)
                        }
                        else {
                            print("error de codigo")
                        }
                    })
                }
                let inicioVC = self.storyboard?.instantiateViewController(withIdentifier: "inicioVC")
                self.present(inicioVC!, animated: true, completion: nil)
            })
            print("successfully logged into firebase with google",uid)
        }
        print("successfully logged into Google",user)
    }
}
