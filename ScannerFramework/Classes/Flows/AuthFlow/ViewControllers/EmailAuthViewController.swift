//
//  EmailAuthViewController.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/13/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

class EmailAuthViewController: StateMachineViewController, KeyboardPlaceholderDelegate {
    private struct Constants {
        static let defaultKeyboardPlaceholderHeight: CGFloat = 80.0
        static let emailMinLength: Int = 5
    }
    
    @IBOutlet private weak var authLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var bottomStackView: UIStackView!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var getLinkButton: UIButton!
    @IBOutlet private weak var emailTextFieldHeight: NSLayoutConstraint!
    @IBOutlet private weak var getLinkButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var keyboardPlaceholderHeight: NSLayoutConstraint!
    @IBOutlet private weak var stringStylization: StringStylization!
    
    var onGetAuthCode: ((String) -> Void)?
    var appType: AppType!
    private var currentTask: URLSessionTask?
    private let repo = Repository()
    private var isGetLinkEnabled = false {
        didSet {
            getLinkButton.isEnabled = isGetLinkEnabled
            getLinkButton.tintColor = isGetLinkEnabled ? .white : .disabledText
        }
    }
    
    private var isLoading: Bool = false {
        didSet {
            showLoading(isLoading)
            isGetLinkEnabled = !isLoading
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localize()
        setup()
        #if DEBUG
            emailTextField.text = "alexander.kozlov@itomy.ch"
            isGetLinkEnabled = true
        #endif
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        emailTextField.resignFirstResponder()
    }
    
    // MARK: - Action
    
    @IBAction func onButtonTap(_ sender: UIButton) {
        validateEmailAndSendRequest()
    }
    
    // MARK: - Private
    
    private func setup() {
        repo.handler = self
        keyboardPlaceholderHeight.constant = UIScreen.main.getRelativeHeight(for: Constants.defaultKeyboardPlaceholderHeight)
        bottomStackView.spacing = UIScreen.main.getRelativeHeight(for: bottomStackView.spacing)
        emailTextFieldHeight.constant = UIScreen.main.getRelativeHeight(for: emailTextFieldHeight.constant)
        getLinkButtonHeight.constant = UIScreen.main.getRelativeHeight(for: getLinkButtonHeight.constant)
        getLinkButton.setBackgroundColor(color: UIColor.disabledBackground, forState: .disabled)
    }
    
    private func validateEmailAndSendRequest() {
        do {
            try emailTextField.text?.validateWith(rules: [.email])
        } catch {
            let errorAlert = UIAlertController.alert(with: error)
            present(errorAlert, animated: true)
            return
        }
        emailTextField.resignFirstResponder()
        sendEmailAuthRequest()
    }
    
    private func sendEmailAuthRequest() {
        guard let email = emailTextField.text else { return }
        currentTask = repo.sendAuthByEmail(email, authSource: appType.authSource)
    }
    
    // MARK: - StateMachine
    
    override func handleContainer(_ container: Container) {
        isLoading = false
        guard case let Container.authKey(authCodeModel) = container else {
            return
        }
        onGetAuthCode?(authCodeModel.key)
    }
    
    override func setLoading() {
        isLoading = true
    }
    
    override func handleErrors(_ error: Error) {
        isLoading = false
        super.handleErrors(error)
    }
}

extension EmailAuthViewController: Localizable {
    func localize() {
        authLabel.text = L10n.authTitle
        descriptionLabel.text = L10n.emailAuthDescription
        emailTextField.placeholder = L10n.emailPlaceholder
        getLinkButton.setAttributedTitle(stringStylization.styleWithLetterSpacing(L10n.getLinkTitle), for: .normal)
    }
}

extension EmailAuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let existingText = textField.text as NSString? else { return false }
        let input = existingText.replacingCharacters(in: range, with: string)
        isGetLinkEnabled = input.count >= Constants.emailMinLength
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        isGetLinkEnabled = false
        return true
    }
}
