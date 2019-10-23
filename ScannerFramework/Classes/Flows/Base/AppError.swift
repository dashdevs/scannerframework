//
//  AppError.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/18/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

public typealias AmountNotReadyProducts = (goods: Int, tare: Int)

public enum AppError: Error, LocalizedError {
    case cantPrint
    case cantCreateAct
    case accessDisabled
    case goodsNotRead(notReadyGoods: AmountNotReadyProducts)
    
    public var errorDescription: String? {
        switch self {
        case .cantPrint:
            return L10n.printError
            
        case .cantCreateAct:
            return L10n.actError
            
        case .accessDisabled:
            return L10n.errorAccessAllowed
            
        case .goodsNotRead(let notReadyGoods):
            var info = String()
            if notReadyGoods.goods > 0 {
                info = L10n.goodsAmount(notReadyGoods.goods)
            }
            if notReadyGoods.tare > 0 {
                info = info.isEmpty ? L10n.tareAmount(notReadyGoods.tare) : "\(info), \(L10n.tareAmount(notReadyGoods.tare))"
            }
            return L10n.goodsNotAcceptedDescription(info)
        }
    }
    
    public var title: String? {
        switch self {
        case .goodsNotRead:
            return L10n.goodsNotAcceptedTitle
        default:
            return nil
        }
    }
}
