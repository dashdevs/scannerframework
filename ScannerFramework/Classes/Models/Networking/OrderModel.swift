//
//  OrderModel.swift
//  GoodsScanner
//
//  Created by Sergei Striuk on 8/21/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

public enum OrderType: String, Decodable {
    case reception = "Reception"
    case consumption = "Consumption"
    case writeOff = "WriteOff"
    case inventory = "Inventory"
    
    public var screenTitle: String {
        switch self {
        case .reception:
            return L10n.incomeScreenTitle
        case .consumption:
            return L10n.consumptionScreenTitle
        case .writeOff:
            return L10n.writeoffScreenTitle
        case .inventory:
            return ""
        }
    }
    
    public var searchPlaceholder: String {
        switch self {
        case .reception:
            return L10n.incomeSearchPlaceholder
        case .consumption:
            return L10n.consumptionSearchPlaceholder
        case .writeOff:
            return L10n.writeoffSearchPlaceholder
        case .inventory:
            return ""
        }
    }
    
    public var orderTitle: String {
        switch self {
        case .reception:
            return L10n.incomeOrderTitle
        case .consumption:
            return L10n.consumptionOrderTitle
        case .writeOff:
            return L10n.writeoffOrderTitle
        case .inventory:
            return ""
        }
    }
    
    public var newOrderTitle: String {
        switch self {
        case .reception:
            return L10n.newIncomeTitle
        case .consumption:
            return L10n.newConsumptionTitle
        case .writeOff:
            return L10n.newWriteoffTitle
        case .inventory:
            return ""
        }
    }
    
    public var actTitle: String {
        switch self {
        case .reception:
            return L10n.actReceptionTitle
        case .consumption:
            return L10n.actConsumptionTitle
        case .writeOff:
            return L10n.actWriteoffTitle
        case .inventory:
            return ""
        }
    }
}

public enum OrderState: String {
    case completed = "Completed"
    case notCompleted = "NotCompleted"
    
    public var queryItem: URLQueryItem {
        return URLQueryItem(name: "State", value: self.rawValue)
    }
}

public struct OrderModel: Decodable {
    public let id: ModelID
    public let number: String
    public let date: Date?
    public let partnerForConsumption: PartnerModel?
    public let partnerForReception: PartnerModel?
    public let processingDate: Date?
    public let userWhoProcessedName: String?
    public let type: OrderType
    public let hasDocument: Bool
    public let total: NSDecimalNumber
    public let isFormed: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case number
        case date
        case partnerForConsumption
        case partnerForReception
        case processingDate
        case userWhoProcessedName
        case type
        case hasDocument
        case total
        case isFormed
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        guard let totalDouble = try? container.decode(Double.self, forKey: .total) else {
            let context = DecodingError.Context(codingPath: [CodingKeys.total], debugDescription: "Can't decode total")
            throw DecodingError.dataCorrupted(context)
        }
        id = try container.decode(ModelID.self, forKey: .id)
        number = try container.decode(String.self, forKey: .number)
        date = try? container.decode(Date.self, forKey: .date)
        partnerForConsumption = try? container.decode(PartnerModel.self, forKey: .partnerForConsumption)
        partnerForReception = try? container.decode(PartnerModel.self, forKey: .partnerForReception)
        processingDate = try? container.decode(Date.self, forKey: .processingDate)
        userWhoProcessedName = try? container.decode(String.self, forKey: .userWhoProcessedName)
        type = try container.decode(OrderType.self, forKey: .type)
        hasDocument = try container.decode(Bool.self, forKey: .hasDocument)
        total = NSDecimalNumber(value: totalDouble)
        isFormed = (try? container.decode(Bool.self, forKey: .isFormed)) ?? false
    }
}

public struct OrdersModel: Decodable {
    public let orders: [OrderModel]
    public let total: ModelID
}
