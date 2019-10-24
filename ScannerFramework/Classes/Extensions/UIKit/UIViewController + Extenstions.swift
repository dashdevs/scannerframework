//
//  UIViewController + Extenstions.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/30/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import AVFoundation
import UIKit

extension UIViewController {
    public func showLoading(_ state: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = state
    }
}

public protocol RequestVideoPermission {
    var requestDescription: String { get }
    func requestVideoPermission(onSuccess: @escaping (() -> Void))
}

extension RequestVideoPermission where Self: UIViewController {
    public func requestVideoPermission(onSuccess: @escaping (() -> Void)) {
        AVCaptureDevice.requestAccess(for: .video) { response in
            DispatchQueue.main.async {
                guard response else {
                    let alert = UIAlertController(title: L10n.cameraTitle, message: self.requestDescription, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: L10n.okButtonTitle, style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: L10n.settingsButtonTitle, style: .default, handler: { _ in
                        UIApplication.shared.open(url: URL(string: UIApplication.openSettingsURLString)!)
                    }))
                    
                    self.present(alert, animated: true)
                    return
                }
                onSuccess()
            }
        }
    }
}

public protocol PresentErrorProtocol {
    func presentError(_ error: Error, title: String?, handler: ((UIAlertAction) ->Void)?)
}

extension PresentErrorProtocol where Self: UIViewController {
    public func presentError(_ error: Error, title: String? = nil, handler: ((UIAlertAction) ->Void)? = nil) {
        let errorAlert = UIAlertController.alert(with: error, title: title, handler: handler)
        present(errorAlert, animated: true)
    }
}
