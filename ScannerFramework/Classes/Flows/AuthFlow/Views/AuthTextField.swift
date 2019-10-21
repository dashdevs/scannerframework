//
//  AuthTextField.swift
//  GoodsScanner
//
//  Created by Sergei Striuk on 8/16/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

class AuthTextField: UITextField {
    @IBInspectable var paddingLeft: CGFloat = 0.0
    @IBInspectable var paddingRight: CGFloat = 0.0
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + paddingLeft, y: bounds.origin.y,
                      width: bounds.size.width - paddingLeft - paddingRight, height: bounds.size.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }
}
