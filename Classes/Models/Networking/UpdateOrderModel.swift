//
//  UpdateOrderModel.swift
//  NewReceiptScan
//
//  Created by Alexander Kozlov on 10/4/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

public struct UpdateOrderModel: Encodable {
    let type: String
    let date: Int64?
    let partnerForConsumptionId: ModelID?
    let partnerForReceptionId: ModelID?
    
    public init(type: OrderType, date: Date?, partnerForConsumptionId: ModelID?, partnerForReceptionId: ModelID?) {
        self.type = type.rawValue
        self.partnerForConsumptionId = partnerForConsumptionId
        self.partnerForReceptionId = partnerForReceptionId
        guard let date = date else {
            self.date = nil
            return
        }
        self.date = Int64(exactly: date.timeIntervalSince1970)
    }
}
