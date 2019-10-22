//
//  AccessModels.swift
//  NewReceiptScan
//
//  Created by Alexander Kozlov on 10/14/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

public enum AccessType: String, Codable {
    case adminPanel = "AdminPanel"
    case goodsScannerApp = "GoodsScannerApp"
    case editEmplyees = "EditEmployees"
    case inventory = "Inventory"
    case priceTags = "PriceTags"
    case reception = "Reception"
    case consumption = "Consumption"
    case writeOff = "WriteOff"
    case editOrderFromMobile = "EditOrderFromMobile"
    case createAdmins = "CreateAdmins"
    case createBranchesAccess = "CreateBranchesAccess"
    case importBranchesFromCsvAccess = "ImportBranchesFromCsvAccess"
    case importProductFromCsv = "ImportProductFromCsv"
    case importPartnersFromCsvAccess = "ImportPartnersFromCsvAccess"
    
    public static let receiptScanAccessRequirements: [AccessType] = [.inventory, .priceTags]
    public static let goodsScannerAccessRequirements: [AccessType] = [.writeOff, .reception, .consumption]
}

struct AccessModel: Codable {
    let id: ModelID
    let type: AccessType
    let text: String
}
