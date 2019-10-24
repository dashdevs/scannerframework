//
//  SimpleProductModel.swift
//  GoodsScanner
//
//  Created by Sergei Striuk on 8/21/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

public struct SimpleProductModel: Decodable {
    public let id: ModelID
    public let name: String
    public let code: String
    public let price: NSDecimalNumber
    public let place: String?
    public let count: NSDecimalNumber
    public let articleNo: String?
    public let storage: StorageModel
    let barCodes: [String]?
    let tare: Bool
    // TODO: change to non-optional when backend will be ready
    let measureUnitType: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case code
        case price
        case place
        case count
        case articleNo
        case storage
        case barCodes
        case tare
        case measureUnitType
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        guard let priceDouble = try? container.decode(Double.self, forKey: .price) else {
            let context = DecodingError.Context(codingPath: [CodingKeys.price], debugDescription: "Can't decode price")
            throw DecodingError.dataCorrupted(context)
        }
        
        guard let countDouble = try? container.decode(Double.self, forKey: .count) else {
            let context = DecodingError.Context(codingPath: [CodingKeys.count], debugDescription: "Can't decode count")
            throw DecodingError.dataCorrupted(context)
        }
        
        id = try container.decode(Int64.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        code = try container.decode(String.self, forKey: .code)
        price = NSDecimalNumber(value: priceDouble)
        place = try? container.decode(String.self, forKey: .place)
        count = NSDecimalNumber(value: countDouble)
        articleNo = try? container.decode(String.self, forKey: .articleNo)
        storage = try container.decode(StorageModel.self, forKey: .storage)
        barCodes = try? container.decode([String].self, forKey: .barCodes)
        tare = try container.decode(Bool.self, forKey: .tare)
        measureUnitType = try? container.decode(String.self, forKey: .measureUnitType)
    }
}

public struct ProductsModel: Decodable {
    public let products: [SimpleProductModel]
    public let total: ModelID
}
