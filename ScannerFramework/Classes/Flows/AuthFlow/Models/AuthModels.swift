//
//  AuthCodeModel.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/15/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

struct AuthByEmailModel: Encodable {
    let email: String
    let source: String
}

public struct AuthCodeModel: Codable {
    let key: String
}

struct AuthByPhoneModel: Encodable {
    let phoneNumber: String
    let source: String
}

struct AuthConfirmModel: Encodable {
    let key: String
    let code: String
}

public struct AccessToken: Decodable {
    let accessToken: String
    let tokenType: String
    let refreshToken: String
    let expiresAt: Date
    
    enum CodingKeys: String, CodingKey {
        case accessToken
        case tokenType
        case refreshToken
        case expiresAt
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try container.decode(String.self, forKey: .accessToken)
        tokenType = try container.decode(String.self, forKey: .tokenType)
        refreshToken = try container.decode(String.self, forKey: .refreshToken)
        
        let intValue = try container.decode(Int.self, forKey: .expiresAt)
        guard let timeInterval = TimeInterval(exactly: intValue) else {
            let context = DecodingError.Context(codingPath: [CodingKeys.expiresAt], debugDescription: "Can't decode expiresAt")
            throw DecodingError.dataCorrupted(context)
        }
        expiresAt = Date(timeIntervalSince1970: timeInterval)
    }
}

struct RefreshTokenModel: Encodable {
    let accessToken: String
    let refreshToken: String
}
