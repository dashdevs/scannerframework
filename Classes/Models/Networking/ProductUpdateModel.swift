//
//  ProductUpdateModel.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/16/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

public struct ProductUpdateModel: Encodable {
    let price: Double
    let expectedCount: Double
    let actualCount: Double?
    let dueDate: Int?
    
    public init(price: Double, expectedCount: Double, actualCount: Double?, dueDate: Int?) {
        self.price = price
        self.expectedCount = expectedCount
        self.actualCount = actualCount
        self.dueDate = dueDate
    }
}
