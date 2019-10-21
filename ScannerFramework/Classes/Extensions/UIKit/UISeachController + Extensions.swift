//
//  UISeachController + Extensions.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/10/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

extension UISearchController {
    public static func appSearchController(placeholder: String?) -> UISearchController {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.extendedLayoutIncludesOpaqueBars = true
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.placeholder = placeholder
        
        if #available(iOS 11.0, *) {
        } else {
            searchController.searchBar.setBackgroundImage(UIImage.image(color: .white), for: .any, barMetrics: .default)
        }
        return searchController
    }
    
    public func onDisappear() {
        if #available(iOS 11.0, *) {
            isActive = false
        } else {
            dismiss(animated: false, completion: nil)
        }
    }
}
