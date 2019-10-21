//
//  BranchModels.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/28/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

public struct BranchModel: Codable {
    let id: ModelID
    public let name: String
}

public struct BranchesModel: Decodable {
    public let branches: [BranchModel]
    public let total: ModelID
}
