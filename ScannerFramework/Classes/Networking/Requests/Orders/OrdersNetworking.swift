//
//  OrdersNetworking.swift
//  NewReceiptScan
//
//  Created by Alexander Kozlov on 9/30/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import DashdevsNetworking

protocol OrdersNetworking {
    @discardableResult func getOrderProducts(for orderID: ModelID) -> URLSessionTask
    @discardableResult func deleteOrderProduct(orderID: ModelID, productID: ModelID) -> URLSessionTask
    @discardableResult func updateOrder(orderId: ModelID, updateModel: UpdateOrderModel) -> URLSessionTask
    @discardableResult func createOrderProduct(orderId: ModelID, model: CreateOrderProductModel) -> URLSessionTask
    @discardableResult func updateProductOrder(orderID: ModelID, productID: ModelID, model: ProductUpdateModel) -> URLSessionTask
    @discardableResult func uploadDocument(orderID: ModelID, model: UploadDocumentModel) -> URLSessionTask
    @discardableResult func getOrderDocument(orderId: ModelID) -> URLSessionTask
}

extension DataRepository: OrdersNetworking {
    @discardableResult public func getOrderProducts(for orderID: ModelID) -> URLSessionTask {
        let endpointDescriptor = GetOrderProductsRequest(orderID: orderID)
        handler?.state = .loading
        let urlSessionTask = loader.load(endpointDescriptor,
                                         handler: { [weak self] response, _ in
                                            switch response {
                                            case let .success(response):
                                                self?.handler?.state = .success(.orderProducts(response))
                                            case let .failure(error):
                                                self?.handler?.state = .failure(error)
                                            }
        })
        return urlSessionTask
    }
    
    @discardableResult public func deleteOrderProduct(orderID: ModelID, productID: ModelID) -> URLSessionTask {
        let endpointDescriptor = DeleteOrderProductDescriptor(orderId: orderID, productId: productID)
        handler?.state = .loading
        let urlSessionTask = loader.load(endpointDescriptor,
                                         handler: { [weak self] response, _ in
                                            switch response {
                                            case let .success(response):
                                                self?.handler?.state = .success(.orderProduct(response))
                                            case let .failure(error):
                                                self?.handler?.state = .failure(error)
                                            }
        })
        return urlSessionTask
    }
    
    @discardableResult public func updateOrder(orderId: ModelID, updateModel: UpdateOrderModel) -> URLSessionTask {
        let endpointDescriptor = UpdateOrderDescriptor(orderID: orderId, updateOrderModel: updateModel)
        handler?.state = .loading
        let urlSessionTask = loader.load(endpointDescriptor,
                                         handler: { [weak self] response, _ in
                                            switch response {
                                            case let .success(response):
                                                self?.handler?.state = .success(.updateOrder(response))
                                            case let .failure(error):
                                                self?.handler?.state = .failure(error)
                                            }
        })
        return urlSessionTask
    }
    
    @discardableResult public func createOrderProduct(orderId: ModelID, model: CreateOrderProductModel) -> URLSessionTask {
        let endpointDescriptor = CreateProductOrderDescriptor(orderID: orderId, model: model)
        handler?.state = .loading
        let urlSessionTask = loader.load(endpointDescriptor,
                                         handler: { [weak self] response, _ in
                                            switch response {
                                            case let .success(response):
                                                self?.handler?.state = .success(.orderProduct(response))
                                            case let .failure(error):
                                                self?.handler?.state = .failure(error)
                                            }
        })
        return urlSessionTask
    }
    
    @discardableResult public func updateProductOrder(orderID: ModelID, productID: ModelID, model: ProductUpdateModel) -> URLSessionTask {
        let endpointDescriptor = UpdateProductDescriptor(orderID: orderID, productID: productID, model: model)
        handler?.state = .loading
        let urlSessionTask = loader.send(endpointDescriptor,
                                         handler: { [weak self] response, _ in
                                            switch response {
                                            case let .success(response):
                                                self?.handler?.state = .success(.orderProduct(response))
                                            case let .failure(error):
                                                self?.handler?.state = .failure(error)
                                            }
        })
        return urlSessionTask
    }
    
    @discardableResult public func uploadDocument(orderID: ModelID, model: UploadDocumentModel) -> URLSessionTask {
        let endpointDescriptor = UploadDocumentDescriptor(orderId: orderID, orderModel: model)
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
    
    @discardableResult public func getOrderDocument(orderId: ModelID) -> URLSessionTask {
        let endpointDescriptor = GetDocumentDescriptor(orderID: orderId)
        handler?.state = .loading
        let urlSessionTask = loader.load(endpointDescriptor,
                                         handler: { [weak self] response, _ in
                                            switch response {
                                            case let .success(response):
                                                self?.handler?.state = .success(.document(response))
                                            case let .failure(error):
                                                self?.handler?.state = .failure(error)
                                            }
        })
        return urlSessionTask
    }
}
