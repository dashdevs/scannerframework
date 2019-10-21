//
//  AuthViewController.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/12/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    @IBOutlet private weak var authLabel: UILabel!
    @IBOutlet private weak var emailAuthButton: UIButton!
    @IBOutlet private weak var orLabel: UILabel!
    @IBOutlet private weak var phoneAuthButton: UIButton!
    @IBOutlet private weak var emailAuthButtonHeight: NSLayoutConstraint!
    @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var stringStylization: StringStylization!
    
    var onSelectAuthByEmail: (() -> Void)?
    var onSelectAuthByPhone: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localize()
        setup()
    }
    
    @IBAction func onButtonTap(_ sender: UIButton) {
        if sender == emailAuthButton {
            onSelectAuthByEmail?()
        } else {
            onSelectAuthByPhone?()
        }
    }
    
    private func setup() {
        emailAuthButtonHeight.constant = UIScreen.main.getRelativeHeight(for: emailAuthButtonHeight.constant)
        bottomConstraint.constant = UIScreen.main.getRelativeHeight(for: bottomConstraint.constant)
    }
}

extension AuthViewController: Localizable {
    func localize() {
        authLabel.text = L10n.authTitle
        emailAuthButton.setAttributedTitle(stringStylization.styleWithLetterSpacing(L10n.emailAuthTitle), for: .normal)
        orLabel.text = L10n.orTitle
        phoneAuthButton.setAttributedTitle(stringStylization.styleWithLetterSpacing(L10n.phoneAuthTitle), for: .normal)
    }
}
