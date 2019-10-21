//
//  PrepareDocumentFlowCoordinator.swift
//  NewReceiptScan
//
//  Created by Alexander Kozlov on 10/18/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

public final class PrepareDocumentFlowCoordinator: Coordinator {
    private let router: UINavigationController
    private let onDoneAction: () -> Void
    
    public init(router: UINavigationController, onDoneAction: @escaping (() -> Void)) {
        self.router = router
        self.onDoneAction = onDoneAction
    }
    
    public func start() {}
    
    public func startDocumentFlow(prepareDocumentInfo: PrepareDocumentInfo) {
        showCamera { [weak self] image in
            self?.showGallery(for: prepareDocumentInfo, with: image)
        }
    }
    
    private func showCamera(action: @escaping ((UIImage) -> Void)) {
        let cameraViewController = StoryboardScene.PrepareDocument.cameraScreen.instantiate()
        let viewControllerWithNavbar = UINavigationController.appNavigationController(with: cameraViewController)
        cameraViewController.onPhotoCaptured = { image in
            action(image)
        }
        cameraViewController.modalPresentationStyle = .fullScreen
        router.present(viewControllerWithNavbar, animated: true)
    }
    
    private func showGallery(for prepareDocumentInfo: PrepareDocumentInfo, with image: UIImage) {
        let galleryViewController = StoryboardScene.PrepareDocument.gallery.instantiate()
        galleryViewController.prepareDocumentInfo = prepareDocumentInfo
        galleryViewController.addImage(image)
        galleryViewController.photoAction = { [weak self, weak galleryViewController] in
            self?.showCamera { image in
                galleryViewController?.addImage(image, needUpdate: true)
            }
        }
        galleryViewController.doneAction = { [weak self] in
            self?.onDoneAction()
        }
        
        var viewControllers = router.viewControllers
        viewControllers.append(galleryViewController)
        router.setViewControllers(viewControllers, animated: false)
    }
}
