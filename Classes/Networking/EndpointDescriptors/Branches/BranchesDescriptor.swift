//
//  BranchesDescriptor.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/28/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

class BranchesDescriptor: RequestDescriptor {
    typealias Resource = BranchesModel
    typealias Parameters = Void
    
    private let pageSize: Int = 30
    var path: Endpoint
    var method: HTTPMethod
    var response: Deserializator<BranchesModel>
    var versionPath: Path?
    lazy var detailedErrorHandler: DetailedErrorHandler? = DefaultErrorHandler()
    
    init(filter: String, offset: Int) {
        versionPath = Path(["api", "v1"])
        var queryItems = URLQueryItem.pagingQueryItems(limit: pageSize, offset: offset)
        queryItems.append(URLQueryItem(name: "Search", value: filter))
        path = Endpoint(path: "branches", queryItems: queryItems)
        method = .get
        response = Deserializator<BranchesModel>.json
    }
}
