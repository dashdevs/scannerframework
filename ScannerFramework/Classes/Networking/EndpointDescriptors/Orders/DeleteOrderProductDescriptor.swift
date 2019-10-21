//
//  DeleteOrderProductDescriptor.swift
//  NewReceiptScan
//
//  Created by Alexander Kozlov on 10/3/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

class DeleteOrderProductDescriptor: RequestDescriptor {
    typealias Resource = OrderProductModel
    typealias Parameters = Void
    
    var path: Endpoint
    var method: HTTPMethod
    var response: Deserializator<OrderProductModel> {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .secondsSince1970
        return Deserializator({ data in
            try jsonDecoder.decode(OrderProductModel.self, from: data)
        }, headers: [])
    }
    var versionPath: Path?
    lazy var detailedErrorHandler: DetailedErrorHandler? = DefaultErrorHandler()
    
    init(orderId: ModelID, productId: ModelID) {
        versionPath = Path(["api", "v1"])
        path = Endpoint(path: "orders/\(orderId)/products/\(productId)")
        method = .delete
    }
}
