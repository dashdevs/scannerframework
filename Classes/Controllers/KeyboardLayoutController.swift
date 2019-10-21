//
//  KeyboardLayoutController.swift
//  Dozens
//
//  Created by Sergii Krapivko on 7/23/18.
//

import UIKit

class KeyboardLayoutController: NSObject {
    @IBOutlet weak var delegate: UIViewController?
    
    override init() {
        super.init()
        startListenKeyboard()
    }
    
    func startListenKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func keyboardInfo(from notification: NSNotification) -> (frame: CGRect, duration: TimeInterval) {
        let kbInfo = notification.userInfo!
        let frame = (kbInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = kbInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        return (frame, duration)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let delegate = delegate as? KeyboardLayoutDelegate else { return }
        let info = keyboardInfo(from: notification)
        delegate.keyboardWillShow(in: info.frame, duration: info.duration)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        guard let delegate = delegate as? KeyboardLayoutDelegate else { return }
        delegate.keyboardWillHide(for: keyboardInfo(from: notification).duration)
    }
}
