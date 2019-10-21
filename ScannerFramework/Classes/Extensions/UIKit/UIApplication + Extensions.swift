//
//  UIApplication + Extensions.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/17/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

extension UIApplication {
    public func open(url: URL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
