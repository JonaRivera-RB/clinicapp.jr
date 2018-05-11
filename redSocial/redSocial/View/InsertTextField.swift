//
//  InsertTextField.swift
//  redSocial
//
//  Created by misael rivera on 03/03/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import UIKit

class InsertTextField: UITextField {
    
    
    private var padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    override func awakeFromNib() {
        let placeholder  = NSAttributedString(string: self.placeholder!
            , attributes: [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0.224609375, green: 0.6818547666, blue: 1, alpha: 1)])
        self.attributedPlaceholder = placeholder
        super.awakeFromNib()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}
