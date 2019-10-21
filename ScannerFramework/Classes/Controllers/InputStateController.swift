//
//  File.swift
//  Dozens
//
//  Created by Sergii Krapivko on 7/12/18.
//

import UIKit

@objc enum InputState: Int {
    case empty
    case typing
    case filled
    
    static func stateWithInput(length len: Int, maxLength ml: Int) -> InputState {
        if len == 0 { return .empty }
        if len == ml { return .filled }
        return .typing
    }
}

@objc protocol InputStateProtocol where Self: UIViewController {
    func update(state: InputState)
    @objc optional func pressedReturn()
}

@IBDesignable class InputStateController: NSObject, UITextFieldDelegate {
    @IBOutlet weak var delegate: InputStateProtocol?
    @IBOutlet var lengthValidator: LengthValidator!
    @IBOutlet var charactersValidator: TypingValidator?
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let existingText = textField.text as NSString? else { return false }
        let input = existingText.replacingCharacters(in: range, with: string)
        
        do {
            try lengthValidator.validateTyping(string: input)
            try charactersValidator?.validateTyping(string: input)
            return true
        } catch {
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.pressedReturn?()
        return true
    }
    
    @IBAction func editingChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        let state = InputState.stateWithInput(length: text.count, maxLength: lengthValidator.max)
        delegate?.update(state: state)
    }
}
