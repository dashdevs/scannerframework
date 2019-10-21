//
//  KeyboardLayoutProtocol.swift
//  Dozens
//
//  Created by Sergii Krapivko on 7/25/18.
//

import UIKit

private struct Constants {
    static let compactKeyboardPlaceholderHeight: CGFloat = 20.0
    static let defaultKeyboardPlaceholderHeight: CGFloat = 80.0
    static let animationDuration: TimeInterval = 0.2
}

protocol KeyboardLayoutDelegate: AnyObject {
    func keyboardWillShow(in rect: CGRect, duration: TimeInterval)
    func keyboardWillHide(for duration: TimeInterval)
}

protocol KeyboardPlaceholderDelegate: KeyboardLayoutDelegate {
    var keyboardPlaceholderHeight: NSLayoutConstraint! { get set }
}

extension KeyboardPlaceholderDelegate where Self: UIViewController {
    func keyboardWillShow(in rect: CGRect, duration: TimeInterval) {
        if let keyboardConstraint = keyboardPlaceholderHeight {
            keyboardConstraint.constant = UIScreen.main.getRelativeHeight(for: Constants.compactKeyboardPlaceholderHeight) + rect.size.height
            UIView.animate(withDuration: Constants.animationDuration) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func keyboardWillHide(for duration: TimeInterval) {
        if let keyboardConstraint = keyboardPlaceholderHeight {
            keyboardConstraint.constant = UIScreen.main.getRelativeHeight(for: Constants.defaultKeyboardPlaceholderHeight)
            UIView.animate(withDuration: Constants.animationDuration) {
                self.view.layoutIfNeeded()
            }
        }
    }
}
