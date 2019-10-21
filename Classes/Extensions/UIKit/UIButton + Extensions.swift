//
//  UIButton + Extensions.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/20/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        setBackgroundImage(UIImage.image(color: color), for: forState)
    }
}
