//
//  URLQueryItem + Extensions.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/6/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

extension URLQueryItem {
    static func pagingQueryItems(limit: Int, offset: Int) -> [URLQueryItem] {
        return [URLQueryItem(name: "Limit", value: String(limit)),
                URLQueryItem(name: "Offset", value: String(offset))]
    }
    
    static func sortingQueryItems(sort: String, direction: String) -> [URLQueryItem] {
        return [URLQueryItem(name: "Sort", value: sort),
                URLQueryItem(name: "Direction", value: direction)]
    }
}
