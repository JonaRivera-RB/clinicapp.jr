//
//  reviewVC.swift
//  redSocial
//
//  Created by misael rivera on 26/03/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage


class reviewVC: UIViewController {

    @IBOutlet weak var reviewTxt: UITextView!
    @IBOutlet weak var nombreLbl: UILabel!

    var nombre = ""
    var idClinica = ""
    
    var activityindicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //obtenemos el id de la persona
        let userID = Auth.auth().currentUser?.uid
        
        activityindicator.startAnimating()
        
    DataService.instance.REF_BASE.child("users").child(userID!).observeSingleEvent(of: .value) { (snapshot) in
            //obtenemos valores
            let value = snapshot.value as? NSDictionary
            self.nombre = value!["nombre"] as! String
            self.nombreLbl.text = self.nombre
            print("\(self.nombreLbl.text!)")
            self.activityindicator.stopAnimating()
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(reviewVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    func initReview(id:String)
    {
        idClinica = id
    }
    
    @IBAction func enviarBtn(_ sender: Any) {
        let id = DB_BASE.childByAutoId().key
        let userReview = ["nombre":nombre,
                          "valoracion":"5.0",
                          "review":self.reviewTxt.text!,
                          "id":id,
                          "idClinica":idClinica]
        print("estoy dentro\(idClinica)")
        DataService.instance.createReview(uid: id, reviewDatos: userReview)
        dismiss(animated: true)
    }
    
    @IBAction func regresarBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func  activarIndicador()
    {
        //posicionamos indicador en el centro
        activityindicator.center = self.view.center
        activityindicator.hidesWhenStopped = true
        //agregamos estilo color gris
        activityindicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        //agregamos la vista a una sub vista con la animacion
        activityindicator.accessibilityLabel = "Cargando"
        view.addSubview(activityindicator)
    }
}
