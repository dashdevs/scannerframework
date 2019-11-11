//
//  CreateOrderProductModel.swift
//  NewReceiptScan
//
//  Created by Alexander Kozlov on 10/7/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

public struct CreateOrderProductModel: Encodable {
    public let productID: ModelID
    let price: Double
    let expectedPrice: Double
    let expectedCount: Double
    let actualCount: Double?
    let dueDate: Int64?
    
    public init(productID: ModelID, price: Double, expectedPrice: Double, expectedCount: Double, actualCount: Double?, dueDate: Int64?) {
        self.productID = productID
        self.price = price
        self.expectedPrice = expectedPrice
        self.expectedCount = expectedCount
        self.actualCount = actualCount
        self.dueDate = dueDate
    }
}
