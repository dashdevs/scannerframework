//
//  StateMachineViewController.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/19/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

public enum State {
    case initial
    case loading
    case success(Container)
    case failure(Error)
}

public enum Container {
    case authKey(AuthCodeModel)
    case accessToken(AccessToken)
    case profile(ProfileModel)
    case branches(BranchesModel)
    case products(ProductsModel)
    case orders(OrdersModel)
    case orderProducts(OrderProductsModel)
    case orderProduct(OrderProductModel)
    case partners(PartnersModel)
    case updateOrder(OrderModel)
    case order(OrderModel)
    case settings(SettingsModel)
    case document(GetDocumentModel)
    case storages(StoragesModel)
    case printTag(String)
}

public protocol StateMachine: AnyObject {
    var state: State { get set }
    func update(newState: State)
}

open class StateMachineViewController: UIViewController, StateMachine {
    public var state: State = .initial {
        willSet(newValue) {
            update(newState: newValue)
        }
    }
    
    open func update(newState: State) {
        switch (state, newState) {
        case (_, .loading):
            setLoading()
        case let (_, .success(container)):
            handleContainer(container)
        case let (_, .failure(error)):
            handleErrors(error)
        default:
            print("Transition from \(state) to \(newState) not implemented")
        }
    }
    
    open func handleContainer(_ container: Container) {}
    
    open func setLoading() {}
    
    open func handleErrors(_ error: Error) {
        let errorAlert = UIAlertController.alert(with: error)
        present(errorAlert, animated: true)
    }
}
