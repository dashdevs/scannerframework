//
//  BaseAuthConfirmViewController.swift
//  NewReceiptScan
//
//  Created by Alexander Kozlov on 10/10/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

class BaseAuthConfirmViewController: StateMachineViewController, KeyboardPlaceholderDelegate, PresentErrorProtocol {
    private struct Constants {
        static let defaultKeyboardPlaceholderHeight: CGFloat = 80.0
        static let animationDuration: TimeInterval = 0.2
        static let timerInterval: TimeInterval = 1.0
        static let buttonTextFont = FontFamily.SFProText.medium.font(size: 15.0) ?? UIFont.systemFont(ofSize: 15.0)
    }
    
    @IBOutlet weak var authLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet var digitTextFields: [UITextField]!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var timerMessageLabel: UILabel!
    @IBOutlet weak var keyboardPlaceholderHeight: NSLayoutConstraint!
    @IBOutlet weak var digitTextFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var loginButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var stringStylization: StringStylization!
    
    var currentAuthKey: String!
    var onAuthorize: ((AccessToken) -> Void)?
    var onFinishAuth: ((ProfileModel) -> Void)?
    var appType: AppType!
    
    private let demoEmail = "screenscannerreview@gmail.com"
    private let demoPassword = "5yVghPnU85gDUxfy"
    
    private var timerBlockResend: Timer?
    private let repo = Repository()
    private var timeBlockResendStarted: Date!
    private var blockTimeLeft: TimeInterval {
        let passedTimeInterval = Date().timeIntervalSince(timeBlockResendStarted)
        let timeLeft = (resendTimeOut - passedTimeInterval).rounded(.toNearestOrAwayFromZero)
        return timeLeft
    }
    
    private var isResendEnabled: Bool = true {
        didSet {
            resendButton.isEnabled = isResendEnabled
        }
    }
    
    var loginInputState: InputState = .empty
    private var isLoginFilled: Bool {
        if case .filled = loginInputState {
            return true
        } else {
            return false
        }
    }
    
    let timerFormatter = TimerFormatter()
    let resendTimeOut: TimeInterval = 60
    
    var isLoginEnabled = false {
        didSet {
            loginButton.isEnabled = isLoginEnabled
            loginButton.tintColor = isLoginEnabled ? .white : .disabledText
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localize()
        setup()
        startBlockResend()
        
        // SPIKE - Block of code for Apple review
        if currentAuthKey == demoEmail {
            codeTextField.isUserInteractionEnabled = false
            sendAuthByEmailPassword()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        codeTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        codeTextField.resignFirstResponder()
    }
    
    // MARK: - Actions
    
    @IBAction func onResendTap(_ sender: Any) {
        resendAuthCode()
    }
    
    @IBAction func onLoginTap(_ sender: Any) {
        sendAuthConfirm()
    }
    
    // MARK: - Private
    
    private func setup() {
        repo.handler = self
        keyboardPlaceholderHeight.constant = UIScreen.main.getRelativeHeight(for: Constants.defaultKeyboardPlaceholderHeight)
        digitTextFieldHeight.constant = UIScreen.main.getRelativeHeight(for: digitTextFieldHeight.constant)
        loginButtonHeight.constant = UIScreen.main.getRelativeHeight(for: loginButtonHeight.constant)
        loginButton.setBackgroundColor(color: UIColor.disabledBackground, forState: .disabled)
    }
    
    private func setResendButtonTitle(_ title: String, for state: UIControl.State) {
        let foregroundColor = (state == .disabled) ? UIColor.disabledText : UIColor.black
        let attributedTitle = NSAttributedString(string: title,
                                                 attributes: [.foregroundColor: foregroundColor,
                                                              .font: Constants.buttonTextFont,
                                                              .underlineStyle: NSUnderlineStyle.single.rawValue])
        resendButton.setAttributedTitle(attributedTitle, for: state)
    }
    
    func startBlockResend() {
        isResendEnabled = false
        timeBlockResendStarted = Date()
        timerMessageLabel.text = L10n.timerCodeMessage(timerFormatter.string(from: resendTimeOut))
        UIView.animate(withDuration: Constants.animationDuration) {
            self.timerMessageLabel.alpha = 1.0
            self.timerMessageLabel.isHidden = false
        }
        timerBlockResend = Timer.scheduledTimer(timeInterval: Constants.timerInterval, target: self, selector: #selector(processTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func processTimer() {
        processTime(timeLeft: self.blockTimeLeft)
    }
    
    private func stopBlockResend() {
        timerBlockResend?.invalidate()
        timerBlockResend = nil
        isResendEnabled = true
        timerMessageLabel.isHidden = true
    }
    
    private func displayEnteredCode(input: String) {
        digitTextFields.forEach { $0.text = nil }
        for (index, character) in input.enumerated() {
            digitTextFields[index].text = String(character)
        }
    }
    
    private func resendAuthCode() {
        isResendEnabled = false
        repo.resendCode(currentAuthKey)
    }
    
    private func sendAuthConfirm() {
        guard let code = codeTextField.text else { return }
        isLoginEnabled = false
        repo.sendAuthConfirm(key: currentAuthKey, code: code)
    }
    
    // SPIKE - Block of code for Apple review
    private func sendAuthByEmailPassword() {
        isLoginEnabled = false
        repo.sendAuthByEmailPassword(email: demoEmail, password: demoPassword)
    }
    
    // MARK: - StateMachine
    
    override func setLoading() {
        showLoading(true)
        isResendEnabled = false
    }
    
    override func handleErrors(_ error: Error) {
        showLoading(false)
        isResendEnabled = timerBlockResend == nil
        isLoginEnabled = isLoginFilled
        super.handleErrors(error)
    }
    
    override func handleContainer(_ container: Container) {
        showLoading(false)
        switch container {
        case .authKey(let authCodeModel):
            currentAuthKey = authCodeModel.key
            startBlockResend()
        case .accessToken(let tokens):
            onAuthorize?(tokens)
        case .settings(let settings):
            DataRepository().appSettings = settings.settings
            repo.getUserProfile()
        case .profile(let profile):
            do {
                try profile.isAccessAllowed(for: appType)
                onFinishAuth?(profile)
            } catch {
                presentError(error)
            }
            isLoginEnabled = true
        default:
            break
        }
    }
    
    // MARK: - Public
    
    func processTime(timeLeft: TimeInterval) {
        guard blockTimeLeft > 0 else {
            stopBlockResend()
            return
        }
    }
    
    func getAppSettings() {
        isLoginEnabled = false
        repo.getAppSettings()
    }
}

extension BaseAuthConfirmViewController: Localizable {
    func localize() {
        authLabel.text = L10n.authTitle
        codeLabel.text = L10n.notReceiveCodeTitle
        setResendButtonTitle(L10n.resendCodeTitle, for: .normal)
        setResendButtonTitle(L10n.resendCodeTitle, for: .disabled)
        loginButton.setAttributedTitle(stringStylization.styleWithLetterSpacing(L10n.logInTitle), for: .normal)
    }
}

extension BaseAuthConfirmViewController: InputStateProtocol {
    func update(state: InputState) {
        if let text = codeTextField.text {
            displayEnteredCode(input: text)
        }
        loginInputState = state
        isLoginEnabled = isLoginFilled
    }
}
