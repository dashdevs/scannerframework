//
//  ShowDocumentFlowCoordinator.swift
//  ScannerFramework
//
//  Created by Alexander Kozlov on 10/18/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

public final class ShowDocumentFlowCoordinator: Coordinator {
    private let router: UINavigationController
    private let onAddAction: () -> Void
    
    public init(router: UINavigationController, onAddAction: @escaping (() -> Void)) {
        self.router = router
        self.onAddAction = onAddAction
    }
    
    public func start() {}
    
    public func showDocument(showDocumentInfo: ShowDocumentInfo) {
        let documentViewer = StoryboardScene.ShowDocument.documentViewer.instantiate()
        documentViewer.showDocumentInfo = showDocumentInfo
        documentViewer.onAddNewDocument = { [weak self] in
            self?.onAddAction()
        }
        router.pushViewController(documentViewer, animated: true)
    }
}
