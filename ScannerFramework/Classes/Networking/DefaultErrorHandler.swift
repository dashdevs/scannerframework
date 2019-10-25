//
//  DefaultErrorHandler.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/23/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

public class DefaultErrorHandler: DetailedErrorHandler {
    public init() {}
    
    public func detailedError(from data: Data?, httpStatus: DashdevsNetworking.NetworkError.HTTPError) -> Error {
        if let data = data {
            do {
                let detailedError = try JSONDecoder().decode(DetailedNetworkError.self, from: data)
                return detailedError
            } catch {}
        }
        return DetailedNetworkError(httpError: httpStatus)
    }
}
