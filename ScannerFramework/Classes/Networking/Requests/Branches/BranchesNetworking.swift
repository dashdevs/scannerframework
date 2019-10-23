//
//  BranchesNetworkingswift
//  NewReceiptScan
//
//  Created by Alexander Kozlov on 10/2/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

protocol BranchesNetworking {
    func getBranches(filter: String, offset: Int) -> URLSessionTask
    @discardableResult func getProduct(branchID: ModelID, filter: String, barCode: String?, offset: Int) -> URLSessionTask
    @discardableResult func createOrder(branchId: ModelID, orderType: OrderType, date: Date) -> URLSessionTask
    @discardableResult func getBranchOrders(for branchID: ModelID, filters: OrderFilter, offset: Int) -> URLSessionTask
    @discardableResult func getBranchPartners(for branchID: ModelID, filter: String, offset: Int) -> URLSessionTask
    @discardableResult func getBranchStorages(for branchID: Int64) -> URLSessionTask
}

extension DataRepository: BranchesNetworking {
    public func getBranches(filter: String, offset: Int) -> URLSessionTask {
        let endpointDescriptor = BranchesDescriptor(filter: filter, offset: offset)
        handler?.state = .loading
        let urlSessionTask = loader.load(endpointDescriptor,
                                         handler: { [weak self] response, _ in
                                            switch response {
                                            case let .success(response):
                                                self?.handler?.state = .success(.branches(response))
                                            case let .failure(error):
                                                self?.handler?.state = .failure(error)
                                            }
        })
        return urlSessionTask
    }
    
    @discardableResult public func getProduct(branchID: ModelID, filter: String, barCode: String?, offset: Int) -> URLSessionTask {
        let endpointDescriptor = BranchProductsDescriptor(branchID: branchID, filter: filter, barCode: barCode, offset: offset)
        handler?.state = .loading
        let urlSessionTask = loader.load(endpointDescriptor,
                                         handler: { [weak self] response, _ in
                                            switch response {
                                            case let .success(response):
                                                self?.handler?.state = .success(.products(response))
                                            case let .failure(error):
                                                self?.handler?.state = .failure(error)
                                            }
        })
        return urlSessionTask
    }
    
    @discardableResult public func createOrder(branchId: ModelID, orderType: OrderType, date: Date) -> URLSessionTask {
        let endpointDescriptor = CreateOrderDescriptor(branchId: branchId, orderType: orderType, date: date)
        handler?.state = .loading
        let urlSessionTask = loader.load(endpointDescriptor,
                                         handler: { [weak self] response, _ in
                                            switch response {
                                            case let .success(response):
                                                self?.handler?.state = .success(.order(response))
                                            case let .failure(error):
                                                self?.handler?.state = .failure(error)
                                            }
        })
        return urlSessionTask
    }
    
    @discardableResult public func getBranchOrders(for branchID: ModelID, filters: OrderFilter, offset: Int) -> URLSessionTask {
        let endpointDescriptor = GetBranchOrdersDescriptor(branchID: branchID, orderFilters: filters, offset: offset)
        handler?.state = .loading
        let urlSessionTask = loader.load(endpointDescriptor,
                                         handler: { [weak self] response, _ in
                                             switch response {
                                             case let .success(response):
                                                 self?.handler?.state = .success(.orders(response))
                                             case let .failure(error):
                                                 self?.handler?.state = .failure(error)
                                             }
        })
        return urlSessionTask
    }
    
    @discardableResult public func getBranchPartners(for branchID: ModelID, filter: String, offset: Int) -> URLSessionTask {
        let endpointDescriptor = GetPartnersDescriptor(branchID: branchID, filter: filter, offset: offset)
        handler?.state = .loading
        let urlSessionTask = loader.load(endpointDescriptor,
                                         handler: { [weak self] response, _ in
                                            switch response {
                                            case let .success(response):
                                                self?.handler?.state = .success(.partners(response))
                                            case let .failure(error):
                                                self?.handler?.state = .failure(error)
                                            }
        })
        return urlSessionTask
    }
    
    @discardableResult func getBranchStorages(for branchID: Int64) -> URLSessionTask {
        let endpointDescriptor = BranchStoragesDescriptor(branchID: branchID)
        handler?.state = .loading
        let urlSessionTask = loader.load(endpointDescriptor,
                                         handler: { [weak self] (response, _) in
                                            switch response {
                                            case let .success(response):
                                                self?.cachedBranchStorages = response
                                                self?.handler?.state = .success(.storages(response))
                                            case let .failure(error):
                                                self?.handler?.state = .failure(error)
                                            }
        })
        return urlSessionTask
    }
}
