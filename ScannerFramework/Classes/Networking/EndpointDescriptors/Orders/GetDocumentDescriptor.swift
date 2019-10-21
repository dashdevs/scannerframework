//
//  GetDocumentDescriptor.swift
//  NewReceiptScan
//
//  Created by Alexander Kozlov on 10/15/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

class GetDocumentDescriptor: RequestDescriptor {
    typealias Resource = GetDocumentModel
    typealias Parameters = Void
    
    var path: Endpoint
    var method: HTTPMethod
    var response: Deserializator<GetDocumentModel>
    var versionPath: Path?
    lazy var detailedErrorHandler: DetailedErrorHandler? = DefaultErrorHandler()
    
    init(orderID: Int64) {
        versionPath = Path(["api", "v1"])
        path = Endpoint(path: "orders/\(orderID)/documents")
        method = .get
        response = Deserializator<GetDocumentModel>.json
    }
}
