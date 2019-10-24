//
//  UserRoleModel.swift
//  ScannerFramework
//
//  Created by Alexander Kozlov on 10/23/19.
//

import Foundation

struct UserRoleModel: Decodable {
    let id: ModelID
    let name: String
    let accessTypes: [AccessModel]
    let roleType: Int32
}
