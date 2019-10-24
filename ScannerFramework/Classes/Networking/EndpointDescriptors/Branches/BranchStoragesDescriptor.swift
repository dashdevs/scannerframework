//
//  BranchStoragesDescriptor.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/2/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

class BranchStoragesDescriptor: RequestDescriptor {
    typealias Resource = StoragesModel
    typealias Parameters = Void
    
    var path: Endpoint
    var method: HTTPMethod
    var response: Deserializator<StoragesModel>
    var versionPath: Path?
    lazy var detailedErrorHandler: DetailedErrorHandler? = DefaultErrorHandler()
    
    init(branchID: Int64) {
        versionPath = Path(["api", "v1"])
        path = Endpoint(path: "branches/\(branchID)/storages")
        method = .get
        response = Deserializator<StoragesModel>.json
    }
}
