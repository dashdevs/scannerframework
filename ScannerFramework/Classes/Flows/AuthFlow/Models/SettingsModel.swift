//
//  SettingsModel.swift
//  NewReceiptScan
//
//  Created by Alexander Kozlov on 10/14/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

public enum SettingType: Int, Codable {
    case allowToChangeCountInOrder = 1
    case allowToAddProductsToFormedOrder
    case allowToChangePriceInOrder
    case allowToCreateNewOrders
}

public struct SettingModel: Codable {
    let id: ModelID
    let type: SettingType
    let text: String
    let isEnabled: Bool
}

public struct SettingsModel: Decodable {
    let settings: [SettingModel]
}
