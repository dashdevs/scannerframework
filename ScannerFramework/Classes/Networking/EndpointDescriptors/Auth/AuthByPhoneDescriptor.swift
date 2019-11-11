//
//  AuthByPhoneDescriptor.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/16/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

class AuthByPhoneDescriptor: RequestDescriptor {
    typealias Resource = AuthCodeModel
    typealias Parameters = AuthByPhoneModel
    
    var path: Endpoint
    var method: HTTPMethod
    var response: Deserializator<AuthCodeModel>
    var parameters: AuthByPhoneModel?
    var encoding: ParamEncoding<AuthByPhoneModel>?
    var versionPath: Path?
    lazy var detailedErrorHandler: DetailedErrorHandler? = DefaultErrorHandler()
    
    init(phoneNumber: String, authSource: String) {
        versionPath = Path(["api", "v1"])
        parameters = AuthByPhoneModel(phoneNumber: phoneNumber, source: authSource)
        path = Endpoint(path: "auth/phone")
        method = .post
        response = Deserializator<AuthCodeModel>.json
        encoding = .json
    }
}
