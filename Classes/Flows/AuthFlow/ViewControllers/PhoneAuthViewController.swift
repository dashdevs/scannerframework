//
//  PhoneAuthViewController.swift
//  GoodsScanner
//
//  Created by Sergei Striuk on 8/14/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

class PhoneAuthViewController: StateMachineViewController, KeyboardPlaceholderDelegate {
    private struct Constants {
        static let defaultKeyboardPlaceholderHeight: CGFloat = 80.0
        static let phoneNumberTextFieldPrefix = "+38"
        static let phoneNumberMask = "+38 ( 0 _ _ )  _ _ _ _  _ _  _ _"
        static let phoneNumberLength: Int = 13
    }
    
    @IBOutlet private weak var authLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var bottomStackView: UIStackView!
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    @IBOutlet private weak var getCodeButton: UIButton!
    @IBOutlet weak var keyboardPlaceholderHeight: NSLayoutConstraint!
    @IBOutlet private weak var phoneNumberTextFieldHeight: NSLayoutConstraint!
    @IBOutlet private weak var getCodeButtonHeight: NSLayoutConstraint!
    @IBOutlet private weak var stringStylization: StringStylization!
    
    var onGetAuthCode: ((String) -> Void)?
    private var currentTask: URLSessionTask?
    private let repo = Repository()
    private var isGetCodeEnabled = false {
        didSet {
            getCodeButton.isEnabled = isGetCodeEnabled
            getCodeButton.tintColor = isGetCodeEnabled ? .white : .disabledText
        }
    }
    
    private var isLoading: Bool = false {
        didSet {
            showLoading(isLoading)
            isGetCodeEnabled = !isLoading
        }
    }
    
    private var phoneNumber: String {
        get { return phoneNumberTextField.text?.fromPhoneNumber() ?? "" }
        set { phoneNumberTextField.text = newValue.toPhoneNumber() }
    }
    
    private var isPhoneNumberValid: Bool {
        do {
            try phoneNumber.validateWith(rules: [.nonEmpty,
                                                 .length(min: Constants.phoneNumberLength, max: Constants.phoneNumberLength, typingMin: Constants.phoneNumberLength)])
            return true
        } catch {
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localize()
        #if DEBUG
            phoneNumberTextField.text = "+380504017113"
            phoneNumber = "+380504017113"
        #endif
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        phoneNumberTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        phoneNumberTextField.resignFirstResponder()
    }
    
    // MARK: - Private
    
    private func setup() {
        repo.handler = self
        keyboardPlaceholderHeight.constant = UIScreen.main.getRelativeHeight(for: Constants.defaultKeyboardPlaceholderHeight)
        bottomStackView.spacing = UIScreen.main.getRelativeHeight(for: bottomStackView.spacing)
        phoneNumberTextFieldHeight.constant = UIScreen.main.getRelativeHeight(for: phoneNumberTextFieldHeight.constant)
        getCodeButtonHeight.constant = UIScreen.main.getRelativeHeight(for: getCodeButtonHeight.constant)
        getCodeButton.setBackgroundColor(color: UIColor.disabledBackground, forState: .disabled)
        isGetCodeEnabled = isPhoneNumberValid
    }
    
    private func sendAuthByPhoneNumber() {
        currentTask = repo.sendAuthByPhone(phoneNumber)
    }
    
    private func isOnlyPhoneCharacters(in string: String) -> Bool {
        do {
            try string.validateWith(rules: [.phoneCharacters])
            return true
        } catch {
            return false
        }
    }
    
    // MARK: - StateMachine
    
    override func setLoading() {
        isLoading = true
    }
    
    override func handleErrors(_ error: Error) {
        isLoading = false
        super.handleErrors(error)
    }
    
    override func handleContainer(_ container: Container) {
        isLoading = false
        guard case let Container.authKey(authCodeModel) = container else {
            return
        }
        onGetAuthCode?(authCodeModel.key)
    }
    
    // MARK: - Actions
    
    @IBAction func onButtonTap(_ sender: UIButton) {
        sendAuthByPhoneNumber()
    }
}

extension PhoneAuthViewController: Localizable {
    func localize() {
        authLabel.text = L10n.authTitle
        descriptionLabel.text = L10n.phoneAuthDescription
        phoneNumberTextField.attributedPlaceholder = NSAttributedString(string: Constants.phoneNumberMask,
                                                                        attributes: [.foregroundColor: UIColor.placeholder])
        getCodeButton.setAttributedTitle(stringStylization.styleWithLetterSpacing(L10n.getCodeTitle), for: .normal)
    }
}

extension PhoneAuthViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if phoneNumber.isEmpty {
            phoneNumber = Constants.phoneNumberTextFieldPrefix
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text,
            let swiftRange = Range(range, in: currentText),
            let cursorRange = textField.selectedTextRange,
            isOnlyPhoneCharacters(in: string) || string.isEmpty else {
            return false
        }
        let newText = currentText.replacingCharacters(in: swiftRange, with: string)
        guard newText.count > Constants.phoneNumberTextFieldPrefix.count else {
            return false
        }
        
        phoneNumber = newText.fromPhoneNumber()
        
        let offset = phoneNumber.toPhoneNumber().distanceToNextDigit(from: range.location, toEnd: !string.isEmpty) + 1
        if let newPosition = textField.position(from: cursorRange.start, offset: offset) {
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
        
        isGetCodeEnabled = isPhoneNumberValid
        return false
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        phoneNumber = Constants.phoneNumberTextFieldPrefix
        textField.text = phoneNumber
        isGetCodeEnabled = false
        return false
    }
}
