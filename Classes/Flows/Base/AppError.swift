//
//  AppError.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/18/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

public enum AppError: Error, LocalizedError {
    case cantPrint
    case cantCreateAct
    
    public var errorDescription: String? {
        switch self {
        case .cantPrint:
            return L10n.printError
            
        case .cantCreateAct:
            return L10n.actError
        }
    }
}
