//
//  UpdateProductDescriptor.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/16/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

class UpdateProductDescriptor: RequestDescriptor {
    typealias Resource = OrderProductModel
    typealias Parameters = ProductUpdateModel
    
    var path: Endpoint
    var method: HTTPMethod
    var response: Deserializator<OrderProductModel> {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .secondsSince1970
        return Deserializator({ data in
            try jsonDecoder.decode(OrderProductModel.self, from: data)
        }, headers: [])
    }
    var parameters: ProductUpdateModel?
    var encoding: ParamEncoding<ProductUpdateModel>?
    var versionPath: Path?
    lazy var detailedErrorHandler: DetailedErrorHandler? = DefaultErrorHandler()
    
    init(orderID: ModelID, productID: ModelID, model: ProductUpdateModel) {
        versionPath = Path(["api", "v1"])
        parameters = model
        path = Endpoint(path: "orders/\(orderID)/products/\(productID)")
        method = .put
        encoding = .json
    }
}
