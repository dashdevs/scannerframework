//
//  AuthByDemoEmailDescriptor.swift
//  ScannerFramework
//
//  Created by Denys Trush on 14.10.2021.
//

import DashdevsNetworking

class AuthByEmailPasswordDescriptor: RequestDescriptor {
    typealias Resource = AccessToken
    typealias Parameters = AuthByEmailPasswordModel
    
    var path: Endpoint
    var method: HTTPMethod
    var response: Deserializator<AccessToken>
    var parameters: AuthByEmailPasswordModel?
    var encoding: ParamEncoding<AuthByEmailPasswordModel>?
    var versionPath: Path?
    lazy var detailedErrorHandler: DetailedErrorHandler? = DefaultErrorHandler()
    
    init(email: String, password: String) {
        versionPath = Path(["api", "v1"])
        parameters = AuthByEmailPasswordModel(email: email, password: password)
        path = Endpoint(path: "auth/password")
        method = .post
        response = Deserializator<AccessToken>.json
        encoding = .json
    }
}
