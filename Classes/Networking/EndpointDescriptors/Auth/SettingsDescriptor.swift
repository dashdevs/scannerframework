//
//  SettingsDescriptor.swift
//  NewReceiptScan
//
//  Created by Alexander Kozlov on 10/14/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

class SettingsDescriptor: RequestDescriptor {
    typealias Resource = SettingsModel
    typealias Parameters = Void
    
    var path: Endpoint
    var method: HTTPMethod
    var response: Deserializator<SettingsModel>
    var versionPath: Path?
    lazy var detailedErrorHandler: DetailedErrorHandler? = DefaultErrorHandler()
    
    init() {
        versionPath = Path(["api", "v1"])
        path = Endpoint(path: "settings")
        method = .get
        response = Deserializator<SettingsModel>.json
    }
}
