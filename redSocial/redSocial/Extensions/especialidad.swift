//
//  especialidad.swift
//  redSocial
//
//  Created by misael rivera on 02/05/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import Foundation
struct especialidad {
    private(set) public var especialidadNombre:String
    private(set) public var idEspecialidad:String
    
    init(especialidadNombre:String,idEspecialidad:String)
    {
        self.especialidadNombre = especialidadNombre
        self.idEspecialidad = idEspecialidad
    }
}
