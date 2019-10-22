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
    
    func isAccessAllowed(for appType: AppType) throws {
        guard accesses.contains(where: { accessModel in
            appType.availableAccess.first { $0 == accessModel.type } != nil
        }) else {
            throw AppError.accessDisabled
        }
    }
}
