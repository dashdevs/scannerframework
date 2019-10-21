//
//  AuthConfirmDescriptor.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/20/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

class AuthConfirmDescriptor: RequestDescriptor {
    typealias Resource = AccessToken
    typealias Parameters = AuthConfirmModel
    
    var path: Endpoint
    var method: HTTPMethod
    var response: Deserializator<AccessToken>
    var parameters: AuthConfirmModel?
    var encoding: ParamEncoding<AuthConfirmModel>?
    var versionPath: Path?
    lazy var detailedErrorHandler: DetailedErrorHandler? = DefaultErrorHandler()
    
    init(key: String, code: String) {
        versionPath = Path(["api", "v1"])
        parameters = AuthConfirmModel(key: key, code: code)
        path = Endpoint(path: "auth/confirm")
        method = .post
        response = Deserializator<AccessToken>.json
        encoding = .json
    }
}
