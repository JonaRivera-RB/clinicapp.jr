//
//  especialidades.swift
//  redSocial
//
//  Created by misael rivera on 17/04/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class especialidades: UIViewController {

    @IBOutlet weak var especialidadTxt: UITextField!
    @IBOutlet weak var idClinicaTxt: UITextField!
    @IBOutlet weak var clinicaTxt: UITextField!
    
    var idClinica = ""
    var clinica = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        clinicaTxt.text = clinica
        idClinicaTxt.text = idClinica
    }
    
    /*
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
 */
    
    @IBAction func agregarBtn(_ sender: Any) {
        let id = DB_BASE.childByAutoId().key
        let especialidad = ["clinica":clinica,
                            "idClinica":idClinica,
                            "idEspecialidad":id,
                            "especialidad":especialidadTxt.text!
        ]
        DataService.instance.createEspecialidades(clinica: clinica, uid: id, especialidad: especialidad)
    }
    func initReview(id:String,clinicaNombre:String)
    {
        idClinica = id
        clinica = clinicaNombre
    }
    @IBAction func salirBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
