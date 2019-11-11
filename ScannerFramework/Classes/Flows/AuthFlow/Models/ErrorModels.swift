//
//  ErrorModels.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/23/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

public struct DetailedNetworkError: Decodable, LocalizedError {
    let errorCode: Int
    let message: String
    let sourceError: DashdevsNetworking.NetworkError.HTTPError?
    public var errorDescription: String? {
        return message
    }
    
    enum CodingKeys: CodingKey {
        case ErrorCode
        case Message
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try container.decode(Int.self, forKey: .ErrorCode)
        message = try container.decode(String.self, forKey: .Message)
        sourceError = nil
    }
    
    public init(httpError: DashdevsNetworking.NetworkError.HTTPError) {
        errorCode = 0
        sourceError = httpError
        switch httpError {
        case .client:
            message = "Client request error"
        case .unautorized:
            message = "Unathorized access"
        case .notFound:
            message = "Resource not found"
        case .forbidden:
            message = "Forbidden"
        case .server:
            message = "Server error"
        case .unknown(let errorCode):
            switch errorCode {
            case 408:
                message = "Request timeout"
            default:
                message = "NetworkError (code = \(errorCode))"
            }
        }
    }
}
