//
//  ResendCodeDescriptor.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/16/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

class ResendCodeDescriptor: RequestDescriptor {
    typealias Resource = AuthCodeModel
    typealias Parameters = AuthCodeModel
    
    var path: Endpoint
    var method: HTTPMethod
    var response: Deserializator<AuthCodeModel>
    var parameters: AuthCodeModel?
    var encoding: ParamEncoding<AuthCodeModel>?
    var versionPath: Path?
    lazy var detailedErrorHandler: DetailedErrorHandler? = DefaultErrorHandler()
    
    init(key: String) {
        versionPath = Path(["api", "v1"])
        parameters = AuthCodeModel(key: key)
        path = Endpoint(path: "auth/resend")
        method = .post
        response = Deserializator<AuthCodeModel>.json
        encoding = .json
    }
}
