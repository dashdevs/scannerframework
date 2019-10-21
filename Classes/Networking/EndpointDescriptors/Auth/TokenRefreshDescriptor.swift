//
//  TokenRefreshDescriptor.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/27/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

class TokenRefreshDescriptor: RequestDescriptor {
    typealias Resource = AccessToken
    typealias Parameters = RefreshTokenModel
    
    var path: Endpoint
    var method: HTTPMethod
    var response: Deserializator<AccessToken>
    var parameters: RefreshTokenModel?
    var encoding: ParamEncoding<RefreshTokenModel>?
    var versionPath: Path?
    lazy var detailedErrorHandler: DetailedErrorHandler? = DefaultErrorHandler()
    
    init(accessToken: String, refreshToken: String) {
        versionPath = Path(["api", "v1"])
        parameters = RefreshTokenModel(accessToken: accessToken, refreshToken: refreshToken)
        path = Endpoint(path: "auth/token")
        method = .post
        response = Deserializator<AccessToken>.json
        encoding = .json
    }
}
