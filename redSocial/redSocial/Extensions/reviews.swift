//
//  reviews.swift
//  redSocial
//
//  Created by misael rivera on 28/03/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import Foundation
struct reviews {
    private(set) public var nombreAutor:String
    private(set) public var fechaReview:String
    private(set) public var reviewDice:String
    
    init(nombreAutor:String,fechaReview:String,reviewDice:String)
    {
        self.nombreAutor = nombreAutor
        self.fechaReview = fechaReview
        self.reviewDice = reviewDice
    }
}
