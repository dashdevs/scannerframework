//
//  GetPartnersDescriptor.swift
//  NewReceiptScan
//
//  Created by Alexander Kozlov on 10/4/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

class GetPartnersDescriptor: RequestDescriptor {
    typealias Resource = PartnersModel
    typealias Parameters = Void
    
    private let pageSize: Int = 30
    var path: Endpoint
    var method: HTTPMethod
    var response: Deserializator<PartnersModel>
    var versionPath: Path?
    lazy var detailedErrorHandler: DetailedErrorHandler? = DefaultErrorHandler()
    
    init(branchID: ModelID, filter: String, offset: Int) {
        versionPath = Path(["api", "v1"])
        var queryItems = URLQueryItem.pagingQueryItems(limit: pageSize, offset: offset)
        queryItems.append(URLQueryItem(name: "Search", value: filter))
        path = Endpoint(path: "branches/\(branchID)/partners", queryItems: queryItems)
        method = .get
        response = Deserializator<PartnersModel>.json
    }
}
