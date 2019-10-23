//
//  UserOrderModel.swift
//  DashdevsNetworking
//
//  Created by Alexander Kozlov on 10/23/19.
//

import Foundation

public struct UserOrderModel: Decodable {
    let id: ModelID
    let firstName: String
    let lastName: String
    let middleName: String?
    let email: String
    let phoneNumber: String
    let isBlocked: Bool
    let role: UserRoleModel
}

