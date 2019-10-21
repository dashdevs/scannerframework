//
//  CreateOrderDescriptor.swift
//  NewReceiptScan
//
//  Created by Alexander Kozlov on 10/14/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

class CreateOrderDescriptor: RequestDescriptor {
    typealias Resource = OrderModel
    typealias Parameters = CreateOrderModel
    
    var path: Endpoint
    var method: HTTPMethod
    var response: Deserializator<OrderModel> {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .secondsSince1970
        return Deserializator({ data in
            try jsonDecoder.decode(OrderModel.self, from: data)
        }, headers: [])
    }
    var parameters: CreateOrderModel?
    var encoding: ParamEncoding<CreateOrderModel>?
    var versionPath: Path?
    lazy var detailedErrorHandler: DetailedErrorHandler? = DefaultErrorHandler()
    
    init(branchId: ModelID, orderType: OrderType, date: Date) {
        versionPath = Path(["api", "v1"])
        parameters = CreateOrderModel(orderType: orderType, date: date)
        path = Endpoint(path: "branches/\(branchId)/orders")
        method = .post
        encoding = .json
    }
}
