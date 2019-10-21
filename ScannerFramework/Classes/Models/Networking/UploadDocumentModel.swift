//
//  UploadDocumentModel.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/23/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

public struct UploadDocumentModel {
    let filename: String
    let data: Data
    let parameters: [String: String]
    
    var mimeType: String {
        switch (filename as NSString).pathExtension {
        case "pdf":
            return "application/pdf"
        case "png":
            return "image/png"
        case "jpeg",
             "jpg":
            return "image/jpeg"
        default:
            return ""
        }
    }
    
    public init(filename: String, data: Data, parameters: [String: String] = [String: String]()) {
        self.filename = filename
        self.data = data
        self.parameters = parameters
    }
}

public struct GetDocumentModel: Decodable {
    public let documentUrl: String
}
