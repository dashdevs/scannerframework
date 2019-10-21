//
//  AuthByEmailDescriptor.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/15/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

class AuthByEmailDescriptor: RequestDescriptor {
    typealias Resource = AuthCodeModel
    typealias Parameters = AuthByEmailModel
    
    private struct Constants {
        static let authSource = "IosApp"
    }
    
    var path: Endpoint
    var method: HTTPMethod
    var response: Deserializator<AuthCodeModel>
    var parameters: AuthByEmailModel?
    var encoding: ParamEncoding<AuthByEmailModel>?
    var versionPath: Path?
    lazy var detailedErrorHandler: DetailedErrorHandler? = DefaultErrorHandler()
    
    init(email: String) {
        versionPath = Path(["api", "v1"])
        parameters = AuthByEmailModel(email: email, source: Constants.authSource)
        path = Endpoint(path: "auth/email")
        method = .post
        response = Deserializator<AuthCodeModel>.json
        encoding = .json
    }
}
