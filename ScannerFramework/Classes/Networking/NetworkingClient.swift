//
//  NetworkingClient.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/19/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

class AppNetworkClient: NetworkClient {
    static let shared = NetworkClient(URL(staticString: "https://goodscaner.kts.kh.ua:64526"), sessionConfiguration: .default, authorization: AuthController.shared)
    
    private override init(_ base: URL, sessionConfiguration: URLSessionConfiguration = .default, authorization: Authorization? = nil) {
        super.init(base, sessionConfiguration: sessionConfiguration, authorization: authorization)
    }
}
