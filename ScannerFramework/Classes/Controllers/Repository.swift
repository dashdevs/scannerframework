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
        if let error = error as? NetworkError.HTTPError, case .unautorized = error {
            if authController.canRefresh {
                authController.refreshToken { [weak self] authResult in
                    switch authResult {
                    case .success:
                        refreshHandler()
                    case .failure:
                        self?.handler?.state = .failure(error)
                        NotificationCenter.default.post(name: .logout, object: nil)
                    }
                    refreshHandler()
                }
            } else {
                handler?.state = .failure(error)
                NotificationCenter.default.post(name: .logout, object: nil)
            }
        } else {
            handler?.state = .failure(error)
        }
    }
}

class Repository: BaseRepository {}
