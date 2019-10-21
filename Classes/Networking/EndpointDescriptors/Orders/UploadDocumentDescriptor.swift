//
//  UploadDocumentDescriptor.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/20/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

class UploadDocumentDescriptor: RequestDescriptor {
    typealias Resource = OrderModel
    typealias Parameters = UploadDocumentModel
    
    var path: Endpoint
    var method: HTTPMethod
    var response: Deserializator<OrderModel>
    var parameters: UploadDocumentModel?
    var encoding: ParamEncoding<UploadDocumentModel>? = {
        let boundary = "Boundary-\(UUID().uuidString)"
        return ParamEncoding<UploadDocumentModel>({ model in
            var body = Data()
            
            let boundaryPrefix = "--\(boundary)\r\n"
            
            for (key, value) in model.parameters {
                body.appendString(boundaryPrefix)
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
            
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"documentFile\"; filename=\"\(model.filename)\"\r\n")
            body.appendString("Content-Type: \(model.mimeType)\r\n\r\n")
            body.append(model.data)
            body.appendString("\r\n")
            body.appendString("--".appending(boundary.appending("--")))
            body.appendString("\r\n")
            
            return body
        }, headers: [HTTPHeader(field: "Content-Type", value: "multipart/form-data; boundary=\(boundary)")])
    }()
    var versionPath: Path?
    lazy var detailedErrorHandler: DetailedErrorHandler? = DefaultErrorHandler()
    
    init(orderId: ModelID, orderModel: UploadDocumentModel) {
        versionPath = Path(["api", "v1"])
        parameters = orderModel
        path = Endpoint(path: "orders/\(orderId)/documents")
        method = .post
        response = Deserializator<OrderModel>.json
    }
}
