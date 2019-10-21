//
//  Data + Extensions.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/23/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

extension Data {
    mutating func appendString(_ string: String) {
        guard let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false) else { return }
        append(data)
    }
}
