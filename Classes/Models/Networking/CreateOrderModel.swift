//
//  CreateOrderModel.swift
//  NewReceiptScan
//
//  Created by Alexander Kozlov on 10/14/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

struct CreateOrderModel: Encodable {
    let type: String
    let date: Int64
    
    init(orderType: OrderType, date: Date) {
        type = orderType.rawValue
        self.date = Int64(date.timeIntervalSince1970)
    }
}
