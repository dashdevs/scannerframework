//
//  Storage.swift
//  GoodsScanner
//
//  Created by Sergei Striuk on 8/21/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

public struct StorageModel: Codable {
    public let id: ModelID
    public let name: String
    
    public init(id: ModelID, name: String) {
        self.id = id
        self.name = name
    }
}

public struct StoragesModel: Codable {
    public let storages: [StorageModel]
}
