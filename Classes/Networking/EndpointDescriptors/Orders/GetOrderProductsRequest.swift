//
//  GetOrderProductsRequest.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/5/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

class GetOrderProductsRequest: RequestDescriptor {
    typealias Resource = OrderProductsModel
    typealias Parameters = Void
    
    var path: Endpoint
    var method: HTTPMethod
    var response: Deserializator<OrderProductsModel> {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .secondsSince1970
        return Deserializator({ data in
            try jsonDecoder.decode(OrderProductsModel.self, from: data)
        }, headers: [])
    }
    
    var versionPath: Path?
    lazy var detailedErrorHandler: DetailedErrorHandler? = DefaultErrorHandler()
    
    init(orderID: Int64) {
        versionPath = Path(["api", "v1"])
        path = Endpoint(path: "orders/\(orderID)/products")
        method = .get
    }
}
