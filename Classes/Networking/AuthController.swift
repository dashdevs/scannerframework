//
//  AuthController.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/19/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

public protocol Authentication {
    var bearerTokenAuth: BearerTokenAuth? { get }
    var refreshToken: String? { get }
    var canRefresh: Bool { get }
}

enum AuthResult {
    case success
    case failure
}

public class AuthController: Authentication {
    public static let shared = AuthController()
    
    public var bearerTokenAuth: BearerTokenAuth?
    public var refreshToken: String?
    private var expiresAt: Date?
    
    public var canRefresh: Bool {
        guard refreshToken != nil, let expiresAt = expiresAt, Date() < expiresAt else {
            return false
        }
        return true
    }
    
    func setAuth(_ response: AccessToken) {
        bearerTokenAuth = BearerTokenAuth(response.accessToken)
        refreshToken = response.refreshToken
        expiresAt = response.expiresAt
    }
    
    public func logout() {
        bearerTokenAuth = nil
        refreshToken = nil
        expiresAt = nil
    }
    
    func refreshToken(then handler: @escaping (AuthResult) -> Void) {
        guard let accessToken = bearerTokenAuth?.token, let refreshToken = refreshToken else {
            handler(.failure)
            return
        }
        
        let endpointDescriptor = TokenRefreshDescriptor(accessToken: accessToken, refreshToken: refreshToken)
        AppNetworkClient.shared.send(endpointDescriptor, handler: { [weak self] response, _ in
            switch response {
            case let .success(result):
                self?.setAuth(result)
                handler(.success)
            case .failure:
                handler(.failure)
            }
        })
    }
}

extension AuthController: Authorization {
    public func authorize(_ request: inout URLRequest) {
        guard let bearerToken = AuthController.shared.bearerTokenAuth else { return }
        bearerToken.authorize(&request)
    }
}
