//
//  AuthNetworking.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/15/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

protocol AuthNetworking {
    func sendAuthByEmail(_ email: String, authSource: String) -> URLSessionTask
    @discardableResult func resendCode(_ key: String) -> URLSessionTask
    func sendAuthByPhone(_ phoneNumber: String, authSource: String) -> URLSessionTask
    @discardableResult func sendAuthConfirm(key: String, code: String) -> URLSessionTask
    @discardableResult func getUserProfile() -> URLSessionTask
    @discardableResult func getAppSettings() -> URLSessionTask
}

extension Repository: AuthNetworking {
    func sendAuthByEmail(_ email: String, authSource: String) -> URLSessionTask {
        let endpointDescriptor = AuthByEmailDescriptor(email: email, authSource: authSource)
        handler?.state = .loading
        let urlSessionTask = loader.send(endpointDescriptor,
                                         handler: { [weak self] response, _ in
                                             switch response {
                                             case let .success(response):
                                                 self?.handler?.state = .success(.authKey(response))
                                             case let .failure(error):
                                                 self?.handler?.state = .failure(error)
                                             }
        })
        return urlSessionTask
    }
    
    @discardableResult func resendCode(_ key: String) -> URLSessionTask {
        let endpointDescriptor = ResendCodeDescriptor(key: key)
        handler?.state = .loading
        let urlSessionTask = loader.send(endpointDescriptor,
                                         handler: { [weak self] response, _ in
                                             switch response {
                                             case let .success(result):
                                                 self?.handler?.state = .success(.authKey(result))
                                             case let .failure(error):
                                                 self?.handler?.state = .failure(error)
                                             }
        })
        return urlSessionTask
    }
    
    func sendAuthByPhone(_ phoneNumber: String, authSource: String) -> URLSessionTask {
        let endpointDescriptor = AuthByPhoneDescriptor(phoneNumber: phoneNumber, authSource: authSource)
        handler?.state = .loading
        let urlSessionTask = loader.send(endpointDescriptor,
                                         handler: { [weak self] response, _ in
                                             switch response {
                                             case let .success(result):
                                                 self?.handler?.state = .success(.authKey(result))
                                             case let .failure(error):
                                                 self?.handler?.state = .failure(error)
                                             }
        })
        return urlSessionTask
    }
    
    @discardableResult func sendAuthConfirm(key: String, code: String) -> URLSessionTask {
        let endpointDescriptor = AuthConfirmDescriptor(key: key, code: code)
        handler?.state = .loading
        let urlSessionTask = loader.send(endpointDescriptor,
                                         handler: { [weak self] response, _ in
                                             switch response {
                                             case let .success(result):
                                                 self?.handler?.state = .success(.accessToken(result))
                                             case let .failure(error):
                                                 self?.handler?.state = .failure(error)
                                             }
        })
        return urlSessionTask
    }
    
    @discardableResult func getUserProfile() -> URLSessionTask {
        let endpointDescriptor = ProfileDescriptor()
        handler?.state = .loading
        let urlSessionTask = loader.load(endpointDescriptor,
                                         handler: { [weak self] response, _ in
                                             switch response {
                                             case let .success(response):
                                                self?.handler?.state = .success(.profile(response))
                                             case let .failure(error):
                                                self?.handle(error) {
                                                    self?.getUserProfile()
                                                }
                                             }
        })
        return urlSessionTask
    }
    
    @discardableResult func getAppSettings() -> URLSessionTask {
        let endpointDescriptor = SettingsDescriptor()
        handler?.state = .loading
        let urlSessionTask = loader.load(endpointDescriptor,
                                         handler: { [weak self] response, _ in
                                             switch response {
                                             case let .success(response):
                                                self?.handler?.state = .success(.settings(response))
                                             case let .failure(error):
                                                self?.handle(error) {
                                                    self?.getAppSettings()
                                                }
                                             }
        })
        return urlSessionTask
    }
}
