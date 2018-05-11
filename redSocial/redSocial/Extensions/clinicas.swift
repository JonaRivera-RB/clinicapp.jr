//
//  clinicas.swift
//  redSocial
//
//  Created by misael rivera on 05/03/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import Foundation
struct clinicas {
    private (set) var nombre:String
    private(set) var direccion:String
    private(set) var telefono:String
    private(set) var foto:String
    private(set) var id:String
    
    init(nombre:String,direccion:String,telefono:String,foto:String,id:String) {
        self.nombre = nombre
        self.direccion = direccion
        self.telefono = telefono
        self.id = id
        self.foto = foto
    }
}
