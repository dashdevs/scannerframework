//
//  PhoneConfirmViewController.swift
//  GoodsScanner
//
//  Created by Sergei Striuk on 8/15/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

class PhoneConfirmViewController: BaseAuthConfirmViewController {
    @IBOutlet private weak var bottomStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func startBlockResend() {
        timerMessageLabel.text = L10n.timerCodeMessage(timerFormatter.string(from: resendTimeOut))
        super.startBlockResend()
    }
    
    override func processTime(timeLeft: TimeInterval) {
        super.processTime(timeLeft: timeLeft)
        timerMessageLabel.text = L10n.timerCodeMessage(timerFormatter.string(from: timeLeft))
    }
    
    // MARK: - Private
    
    private func setup() {
        descriptionLabel.text = L10n.phoneConfirmDescription
        bottomStackView.spacing = UIScreen.main.getRelativeHeight(for: bottomStackView.spacing)
        #if DEBUG
            digitTextFields.forEach { $0.text = "0" }
            codeTextField.text = "0000"
            isLoginEnabled = true
        #endif
    }
}
