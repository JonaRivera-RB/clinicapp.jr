//
//  DataServices.swift
//  redSocial
//
//  Created by misael rivera on 03/03/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import Foundation
import Firebase
//creamos una referencia
let DB_BASE = Database.database().reference()

class DataService {
    static let instance = DataService()
    //creamos referencia a los hijos de la base de datos
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_CLINICAS = DB_BASE.child("clinicas")
    private var _REF_DOCTORES = DB_BASE.child("doctores")
    private var _REF_REVIEWS = DB_BASE.child("reviews")
    private var _REF_ESPECIALIDADES = DB_BASE.child("especialidades")
    //accediendo a las referencias privadas
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_CLINICAS: DatabaseReference {
        return _REF_CLINICAS
    }
    
    var REF_DOCTORES: DatabaseReference {
        return _REF_DOCTORES
    }
    var REF_REVIEWS: DatabaseReference {
        return _REF_REVIEWS
    }
    var REF_ESPECIALIDADES: DatabaseReference {
        return _REF_ESPECIALIDADES
    }
    
    //creamos funcion para poder crear un usuario en la base de datos
    func createDBUser(uid:String, userData:Dictionary<String,Any>)
    {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    func createClinicas(uid:String, clinicaDatos:Dictionary<String, Any>)
    {
        REF_CLINICAS.child(uid).updateChildValues(clinicaDatos)
    }
    func createReview(uid:String,reviewDatos:Dictionary<String, Any>)
    {
        REF_REVIEWS.child(uid).updateChildValues(reviewDatos)
    }
    func createEspecialidades(clinica:String,uid:String,especialidad:Dictionary<String,Any>)
    {
        REF_ESPECIALIDADES.child(clinica).child(uid).updateChildValues(especialidad)
    }
}
