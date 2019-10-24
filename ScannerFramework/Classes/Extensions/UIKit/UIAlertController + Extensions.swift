//
//  UIAlertController + Extensions.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/15/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking
import UIKit

extension UIAlertController {
    public static func alert(with error: Error, title: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController.alert(with: error.localizedDescription, title: title, handler: handler)
        return alert
    }
    
    public static func alert(with message: String, title: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: L10n.okButtonTitle, style: .default, handler: handler)
        alert.addAction(okAction)
        return alert
    }
}
