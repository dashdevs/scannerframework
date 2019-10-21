//
//  StateMachineTableViewController.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/28/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

open class StateMachineTableViewController: UITableViewController, StateMachine {
    private struct Constants {
        static let loaderViewWidth: CGFloat = 100.0
        static let loaderViewHeight: CGFloat = 70.0
    }
    
    private lazy var loaderView: LoaderView = {
        let loaderView = LoaderView()
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        loaderView.widthAnchor.constraint(equalToConstant: Constants.loaderViewWidth).isActive = true
        loaderView.heightAnchor.constraint(equalToConstant: Constants.loaderViewHeight).isActive = true
        return loaderView
    }()
    
    public var isLoaderViewHidden = true {
        didSet {
            guard oldValue != isLoaderViewHidden, let router = navigationController else { return }
            isLoaderViewHidden ? loaderView.removeFromSuperview() : router.view.addSubview(loaderView)
            let constraints = [loaderView.centerXAnchor.constraint(equalTo: router.view.centerXAnchor),
                               loaderView.centerYAnchor.constraint(equalTo: router.view.centerYAnchor)]
            isLoaderViewHidden ? NSLayoutConstraint.deactivate(constraints) : NSLayoutConstraint.activate(constraints)
            tableView.isUserInteractionEnabled = isLoaderViewHidden
            loaderView.isActive = !isLoaderViewHidden
        }
    }
    
    public var state: State = .initial {
        willSet(newValue) {
            update(newState: newValue)
        }
    }
    
    public func update(newState: State) {
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
