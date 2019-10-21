//
//  UIImage + Extensions.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/16/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

extension UIImage {
    public class func image(color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return colorImage
    }
}
