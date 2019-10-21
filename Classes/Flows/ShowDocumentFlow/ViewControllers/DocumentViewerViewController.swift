//
//  DocumentViewerViewController.swift
//  NewReceiptScan
//
//  Created by Alexander Kozlov on 10/15/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit
import WebKit

public typealias ShowDocumentInfo = (isEditable: Bool, documentUrlRequest: URLRequest?)

class DocumentViewerViewController: UIViewController, PresentErrorProtocol {
    private struct Constants {
        static let contentMargin: CGFloat = 3.0
    }
    @IBOutlet private weak var cameraButton: UIBarButtonItem!
    
    private lazy var loaderView = LoaderView()
    private var webView: UIView?
    
    private var isDocumentLoading = false {
        didSet {
            guard oldValue != isDocumentLoading else { return }
            isDocumentLoading ? view.addSubview(loaderView) : loaderView.removeFromSuperview()
            let constraints = [loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                               loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor)]
            isDocumentLoading ? NSLayoutConstraint.activate(constraints) : NSLayoutConstraint.deactivate(constraints)
            loaderView.isActive = isDocumentLoading
            let isEditingEnabled = DataRepository().isUserAccessAllowed(.editOrderFromMobile)
            cameraButton.isEnabled = !isDocumentLoading && showDocumentInfo.isEditable && isEditingEnabled
            webView?.isUserInteractionEnabled = !isDocumentLoading
        }
    }
    
    var showDocumentInfo: ShowDocumentInfo!
    var onAddNewDocument: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        guard let urlRequest = showDocumentInfo.documentUrlRequest else { return }
        var webView: UIView
        if #available(iOS 11.0, *) {
            let wkWebView = WKWebView(frame: view.frame)
            wkWebView.backgroundColor = .gray
            wkWebView.navigationDelegate = self
            wkWebView.isUserInteractionEnabled = false
            wkWebView.load(urlRequest)
            
            webView = wkWebView
        } else {
            let uiWebView = UIWebView(frame: view.frame)
            uiWebView.backgroundColor = .darkGray
            uiWebView.delegate = self
            uiWebView.isUserInteractionEnabled = false
            uiWebView.loadRequest(urlRequest)
            
            webView = uiWebView
        }
        view.backgroundColor = webView.backgroundColor
        webView.isOpaque = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        NSLayoutConstraint.activate([webView.topAnchor.constraint(equalTo: view.topAnchor),
                                     webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     webView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.contentMargin),
                                     webView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.contentMargin)])
        self.webView = webView
    }
    
    @IBAction func onCameraTap(_ sender: Any) {
        onAddNewDocument?()
    }
}

extension DocumentViewerViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        isDocumentLoading = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        isDocumentLoading = false
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        isDocumentLoading = false
        presentError(error)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        isDocumentLoading = false
        presentError(error)
    }
}

extension DocumentViewerViewController: UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        isDocumentLoading = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        isDocumentLoading = false
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        isDocumentLoading = false
        presentError(error)
    }
}
