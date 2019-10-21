//
//  UpdateOrderDescriptor.swift
//  NewReceiptScan
//
//  Created by Alexander Kozlov on 10/4/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

class UpdateOrderDescriptor: RequestDescriptor {
    typealias Resource = OrderModel
    typealias Parameters = UpdateOrderModel
    
    var path: Endpoint
    var method: HTTPMethod
    var response: Deserializator<OrderModel> {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .secondsSince1970
        return Deserializator({ data in
            try jsonDecoder.decode(OrderModel.self, from: data)
        }, headers: [])
    }
    var parameters: UpdateOrderModel?
    var encoding: ParamEncoding<UpdateOrderModel>?
    var versionPath: Path?
    lazy var detailedErrorHandler: DetailedErrorHandler? = DefaultErrorHandler()
    
    init(orderID: ModelID, updateOrderModel: UpdateOrderModel) {
        versionPath = Path(["api", "v1"])
        parameters = updateOrderModel
        path = Endpoint(path: "orders/\(orderID)")
        method = .put
        encoding = .json
    }
}
