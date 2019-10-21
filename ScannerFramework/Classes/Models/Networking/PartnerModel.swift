//
//  Partner.swift
//  GoodsScanner
//
//  Created by Sergei Striuk on 8/21/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

public struct PartnerModel: Decodable {
    public let id: ModelID
    public let name: String
    public let address: String?
    public let taxRegistryCode: String?
}

public struct PartnersModel: Decodable {
    public let partners: [PartnerModel]
    public let total: ModelID
}
