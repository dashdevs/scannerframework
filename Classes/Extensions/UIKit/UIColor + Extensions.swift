//
//  UIColor + Extensions.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/13/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hexColor: Int, alpha: CGFloat = 1.0) {
        let components = (
            red: CGFloat((hexColor >> 16) & 0xff) / 255,
            green: CGFloat((hexColor >> 08) & 0xff) / 255,
            blue: CGFloat((hexColor >> 00) & 0xff) / 255
        )
        self.init(red: components.red, green: components.green, blue: components.blue, alpha: alpha)
    }
}

extension UIColor {
    public static var disabledBackground: UIColor {
        return UIColor(hexColor: 0xF4F4F5)
    }
    
    public static var blue00: UIColor {
        return UIColor(hexColor: 0x007AFF)
    }
    
    public static var disabledText: UIColor {
        return UIColor(hexColor: 0xBCBCBF)
    }
    
    public static var gray8F: UIColor {
        return UIColor(hexColor: 0x8F8E94)
    }
    
    public static var grayB3: UIColor {
        return UIColor(hexColor: 0xB3B3B3)
    }
    
    public static var placeholder: UIColor {
        return UIColor(hexColor: 0xC4C4C6)
    }
    
    public static var grayEF: UIColor {
        return UIColor(hexColor: 0xEFEFF4)
    }
    
    public static var grayF6: UIColor {
        return UIColor(hexColor: 0xF6F6F6)
    }
}
