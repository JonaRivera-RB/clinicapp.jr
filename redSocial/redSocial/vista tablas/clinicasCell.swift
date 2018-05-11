//
//  clinicasCell.swift
//  redSocial
//
//  Created by misael rivera on 07/03/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase
import FirebaseStorage

class clinicasCell: UITableViewCell {
    @IBOutlet weak var clinicaFoto:UIImageView!
    
    func actualizarVista(clinica:clinicas) {
        let urlFoto = clinica.foto
        if urlFoto != "" {
            Storage.storage().reference(forURL: urlFoto).getData(maxSize: 10 * 1024 * 1024, completion: { (data, error) in
                if let error = error?.localizedDescription {
                    print("error al traer imagen", error)
                }
                else
                {
                    self.clinicaFoto.image = UIImage(data: data!)
                }
            })
        }
    }
}
