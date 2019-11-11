//
//  Repository.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/19/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

public class BaseRepository {
    let loader: NetworkClient
    let authController: AuthController
    public weak var handler: StateMachine?
    
    init(_ loader: NetworkClient = AppNetworkClient.shared, auth: AuthController = AuthController.shared) {
        self.loader = loader
        self.authController = auth
    }
    
    func handle(_ error: Error, refreshHandler: @escaping () -> Void) {
        var httpError = error as? NetworkError.HTTPError
        if httpError == nil, let detailedError = error as? DetailedNetworkError {
            httpError = detailedError.sourceError
        }
        if let error = httpError, case .unautorized = error {
            if authController.canRefresh {
                authController.refreshToken { authResult in
                    switch authResult {
                    case .success:
                        refreshHandler()
                    case .failure:
                        NotificationCenter.default.post(name: .logout, object: nil)
                    }
                    refreshHandler()
                }
            } else {
                NotificationCenter.default.post(name: .logout, object: nil)
            }
        } else {
            handler?.state = .failure(error)
        }
    }
}

class Repository: BaseRepository {}
