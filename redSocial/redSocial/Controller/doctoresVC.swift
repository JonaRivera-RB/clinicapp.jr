//
//  doctoresVC.swift
//  redSocial
//
//  Created by misael rivera on 15/05/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import UIKit

class doctoresVC: UIViewController {
    
    var especialidadNombre:String = ""
    var idEspecialidad:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hola mundo aqui estamos \(especialidadNombre)----\(idEspecialidad)")
    }
    func initEspecialidades(especialidades:especialidad)
    {
        especialidadNombre = especialidades.especialidadNombre
        idEspecialidad = especialidades.idEspecialidad
    }
    
    @IBAction func regresarBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
