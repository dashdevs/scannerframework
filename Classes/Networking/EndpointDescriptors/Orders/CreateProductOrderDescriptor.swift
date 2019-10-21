//
//  CreateProductOrderDescriptor.swift
//  NewReceiptScan
//
//  Created by Alexander Kozlov on 10/7/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

class CreateProductOrderDescriptor: RequestDescriptor {
    typealias Resource = OrderProductModel
    typealias Parameters = CreateOrderProductModel
    
    var path: Endpoint
    var method: HTTPMethod
    var response: Deserializator<OrderProductModel> {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .secondsSince1970
        return Deserializator({ data in
            try jsonDecoder.decode(OrderProductModel.self, from: data)
        }, headers: [])
    }
    var parameters: CreateOrderProductModel?
    var encoding: ParamEncoding<CreateOrderProductModel>?
    var versionPath: Path?
    lazy var detailedErrorHandler: DetailedErrorHandler? = DefaultErrorHandler()
    
    init(orderID: ModelID, model: CreateOrderProductModel) {
        versionPath = Path(["api", "v1"])
        parameters = model
        path = Endpoint(path: "orders/\(orderID)/products")
        method = .post
        encoding = .json
    }
}
