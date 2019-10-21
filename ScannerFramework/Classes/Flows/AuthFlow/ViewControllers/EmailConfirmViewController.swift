//
//  EmailConfirmViewController.swift
//  GoodsScanner
//
//  Created by Sergei Striuk on 8/14/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

class EmailConfirmViewController: BaseAuthConfirmViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = L10n.emailConfirmDescription
    }
    
    override func startBlockResend() {
        timerMessageLabel.text = L10n.timerEmailMessags(timerFormatter.string(from: resendTimeOut))
        super.startBlockResend()
    }
    
    override func processTime(timeLeft: TimeInterval) {
        super.processTime(timeLeft: timeLeft)
        timerMessageLabel.text = L10n.timerEmailMessags(timerFormatter.string(from: timeLeft))
    }
}
