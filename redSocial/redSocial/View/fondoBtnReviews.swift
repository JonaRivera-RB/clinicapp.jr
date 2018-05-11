//
//  fondoBtnReviews.swift
//  redSocial
//
//  Created by misael rivera on 26/03/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import UIKit
@IBDesignable
class fondoBtnReviews: UIButton {
    override func prepareForInterfaceBuilder() {
        vistaPersonalizada()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        vistaPersonalizada()
    }
    func vistaPersonalizada()
    {
        layer.borderWidth = 0.2
        layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.cornerRadius = 5
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 5
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
