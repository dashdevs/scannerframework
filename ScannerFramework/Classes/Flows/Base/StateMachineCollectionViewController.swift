//
//  StateMachineCollectionViewController.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/23/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

open class StateMachineCollectionViewController: UICollectionViewController, StateMachine {
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
