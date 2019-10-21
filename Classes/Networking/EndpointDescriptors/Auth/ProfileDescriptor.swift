//
//  ProfileDescriptor.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/28/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

class ProfileDescriptor: RequestDescriptor {
    typealias Resource = ProfileModel
    typealias Parameters = Void
    
    var path: Endpoint
    var method: HTTPMethod
    var response: Deserializator<ProfileModel>
    var versionPath: Path?
    lazy var detailedErrorHandler: DetailedErrorHandler? = DefaultErrorHandler()
    
    init() {
        versionPath = Path(["api", "v1"])
        path = Endpoint(path: "profile")
        method = .get
        response = Deserializator<ProfileModel>.json
    }
}
