//
//  LoaderView.swift
//  NewReceiptScan
//
//  Created by Alexander Kozlov on 9/30/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

public class LoaderView: UIView {
    private struct Constants {
        static let loaderViewWidth: CGFloat = 100.0
        static let loaderViewHeight: CGFloat = 70.0
    }
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    public override var isHidden: Bool {
        didSet {
            super.isHidden = isHidden
            isActive = !isHidden
        }
    }
    
    public var isActive: Bool = false {
        didSet {
            guard activityIndicator != nil else { return }
            isActive ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    private func xibSetup() {
        let bundle = Bundle(for: LoaderView.self)
        guard let view = bundle.loadNibNamed(String(describing: LoaderView.self), owner: self, options: nil)?.first as? UIView else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        let layoutAttributes: [NSLayoutConstraint.Attribute] = [.top, .leading, .bottom, .trailing]
        NSLayoutConstraint.activate(layoutAttributes.map {
            NSLayoutConstraint(item: view, attribute: $0, relatedBy: .equal, toItem: self, attribute: $0, multiplier: 1, constant: 0.0)
        })
        translatesAutoresizingMaskIntoConstraints = false
        
        widthAnchor.constraint(equalToConstant: Constants.loaderViewWidth).isActive = true
        heightAnchor.constraint(equalToConstant: Constants.loaderViewHeight).isActive = true
    }
}
