//
//  UINavigationController + Extensions.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/12/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

extension UINavigationController {
    public static func appNavigationController(with viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(navigationBarClass: NonTranslucentNavigationBar.self, toolbarClass: nil)
        navigationController.viewControllers = [viewController]
        return navigationController
    }
}
