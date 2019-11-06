//
//  OrderProductModel.swift
//  GoodsScanner
//
//  Created by Sergei Striuk on 8/21/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

public struct OrderProductModel: Decodable {
    public let id: Int64
    public let code: String
    public let name: String
    public let tare: Bool
    public let place: String
    public let expectedCount: NSDecimalNumber
    public let actualCount: NSDecimalNumber?
    public let price: NSDecimalNumber
    public let expectedPrice: NSDecimalNumber
    public let dueDate: Date?
    public let access: Bool
    public let storageId: Int64
    public let storageName: String?
    public let barCodes: [String]?
    public let measureUnit: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case code
        case name
        case tare
        case place
        case expectedCount
        case actualCount
        case price
        case expectedPrice
        case dueDate
        case access
        case storageId
        case storageName
        case barCodes
        case measureUnitType
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        guard let priceDouble = try? container.decode(Double.self, forKey: .price) else {
            let context = DecodingError.Context(codingPath: [CodingKeys.price], debugDescription: "Can't decode price")
            throw DecodingError.dataCorrupted(context)
        }
        
        guard let expectedPriceDouble = try? container.decode(Double.self, forKey: .expectedPrice) else {
            let context = DecodingError.Context(codingPath: [CodingKeys.expectedPrice], debugDescription: "Can't decode expectedPrice")
            throw DecodingError.dataCorrupted(context)
        }
        
        guard let expectedCountDouble = try? container.decode(Double.self, forKey: .expectedCount) else {
            let context = DecodingError.Context(codingPath: [CodingKeys.expectedCount], debugDescription: "Can't decode expectedCount")
            throw DecodingError.dataCorrupted(context)
        }
        
        let isActualCountNull = try? container.decodeNil(forKey: .actualCount)
        if isActualCountNull == true {
            actualCount = nil
        } else {
            guard let actualCountDouble = try? container.decodeIfPresent(Double.self, forKey: .actualCount) else {
                let context = DecodingError.Context(codingPath: [CodingKeys.actualCount], debugDescription: "Can't decode actualCount")
                throw DecodingError.dataCorrupted(context)
            }
            actualCount = NSDecimalNumber(value: actualCountDouble)
        }
        
        id = try container.decode(Int64.self, forKey: .id)
        code = try container.decode(String.self, forKey: .code)
        name = try container.decode(String.self, forKey: .name)
        tare = try container.decode(Bool.self, forKey: .tare)
        place = try container.decode(String.self, forKey: .place)
        expectedCount = NSDecimalNumber(value: expectedCountDouble)
        price = NSDecimalNumber(value: priceDouble)
        expectedPrice = NSDecimalNumber(value: expectedPriceDouble)
        dueDate = try? container.decode(Date.self, forKey: .dueDate)
        access = try container.decode(Bool.self, forKey: .access)
        storageId = try container.decode(Int64.self, forKey: .storageId)
        storageName = try? container.decode(String.self, forKey: .storageName)
        barCodes = try? container.decode([String].self, forKey: .barCodes)
        measureUnit = (try? container.decode(String.self, forKey: .measureUnitType)) ?? ""
    }
}

public struct OrderProductsModel: Decodable {
    public let products: [OrderProductModel]
}
