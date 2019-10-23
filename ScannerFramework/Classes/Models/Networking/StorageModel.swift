//
//  Storage.swift
//  GoodsScanner
//
//  Created by Sergei Striuk on 8/21/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

public struct StorageModel: Codable {
    let id: ModelID
    public let name: String
}

public struct StoragesModel: Codable {
    let storages: [StorageModel]
}
