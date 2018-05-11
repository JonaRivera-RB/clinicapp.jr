//
//  reviewCell.swift
//  redSocial
//
//  Created by misael rivera on 28/03/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import UIKit

class reviewCell: UITableViewCell {
    @IBOutlet weak var reviewNombre:UILabel!
    @IBOutlet weak var reviewFecha:UILabel!
    @IBOutlet weak var reviewTexto:UILabel!
    
    func actualizarVista(reviews:reviews){
        reviewNombre.text = reviews.nombreAutor
        reviewFecha.text = reviews.fechaReview
        reviewTexto.text = reviews.reviewDice
    }
}
