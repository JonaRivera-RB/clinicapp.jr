//
//  especialidadesCell.swift
//  redSocial
//
//  Created by misael rivera on 02/05/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import UIKit

class especialidadesCell: UITableViewCell {
    @IBOutlet weak var especialidadNombre:UILabel!
    
    func actualizarVista(especialidades:especialidad){
        especialidadNombre.text = especialidades.especialidadNombre
    }

}
