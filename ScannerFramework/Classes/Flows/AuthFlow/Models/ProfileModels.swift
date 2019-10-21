//
//  ProfileModels.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/28/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

public typealias ModelID = Int64

public struct ProfileModel: Decodable {
    let id: ModelID
    let email: String
    let phoneNumber: String
    let firstName: String
    let lastName: String
    let middleName: String?
    let role: String
    let accesses: [AccessModel]
}
