//
//  GetBranchOrdersDescriptor.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/30/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

class GetBranchOrdersDescriptor: RequestDescriptor {
    typealias Resource = OrdersModel
    typealias Parameters = Void
    
    private let pageSize: Int = 30
    var path: Endpoint
    var method: HTTPMethod
    var response: Deserializator<OrdersModel> {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .secondsSince1970
        return Deserializator({ data in
            try jsonDecoder.decode(OrdersModel.self, from: data)
        }, headers: [])
    }
    
    var versionPath: Path?
    lazy var detailedErrorHandler: DetailedErrorHandler? = DefaultErrorHandler()
    
    init(branchID: ModelID, orderFilters: OrderFilter, offset: Int) {
        versionPath = Path(["api", "v1"])
        var queryItems = orderFilters.queryItems
        queryItems.append(contentsOf: URLQueryItem.pagingQueryItems(limit: pageSize, offset: offset))
        queryItems.append(contentsOf: URLQueryItem.sortingQueryItems(sort: "CreationDate", direction: "Desc"))
        
        path = Endpoint(path: "branches/\(branchID)/orders", queryItems: queryItems)
        method = .get
    }
}
