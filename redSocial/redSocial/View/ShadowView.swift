//
//  ShadowView.swift
//  redSocial
//
//  Created by misael rivera on 03/03/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import UIKit
@IBDesignable

class ShadowView: UIView {
    
    override func prepareForInterfaceBuilder() {
        vistaView()
    }
    override func awakeFromNib() {
        vistaView()
        super.awakeFromNib()
    }
    
    func vistaView()
    {
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.cornerRadius = 0.5
    }
}
