//
//  BranchProductsDescriptor.swift
//  NewReceiptScan
//
//  Created by Alexander Kozlov on 9/30/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

class BranchProductsDescriptor: RequestDescriptor {
    typealias Resource = ProductsModel
    typealias Parameters = Void
    
    private let pageSize: Int = 30
    var path: Endpoint
    var method: HTTPMethod
    var response: Deserializator<ProductsModel>
    var versionPath: Path?
    lazy var detailedErrorHandler: DetailedErrorHandler? = DefaultErrorHandler()
    
    init(branchID: ModelID, filter: String, barCode: String?, offset: Int) {
        versionPath = Path(["api", "v1"])
        var queryItems = URLQueryItem.pagingQueryItems(limit: pageSize, offset: offset)
        queryItems.append(URLQueryItem(name: "Search", value: filter))
        barCode.flatMap { queryItems.append(URLQueryItem(name: "Barcode", value: $0)) }
        path = Endpoint(path: "branches/\(branchID)/products", queryItems: queryItems)
        method = .get
        response = Deserializator<ProductsModel>.json
    }
}
