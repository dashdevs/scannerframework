//
//  LengthValidator.swift
//  Dozens
//
//  Created by Yuriy Gavrilenko on 7/30/18.
//

import Foundation

class LengthValidator: TypingValidator {
    @IBInspectable var min: Int = 0
    @IBInspectable var max: Int = .max
    @IBInspectable var minTyping: Int = 0
    
    convenience init(minLength: Int, maxLength: Int, minTypingLength: Int) {
        self.init()
        minTyping = minTypingLength
        min = minLength
        max = maxLength
    }
    
    override var error: ValidationError {
        return .length
    }
    
    override func validate(string: String) throws {
        if !(min...max).contains(string.count) {
            throw error
        }
    }
    
    func validateTyping(string: String) throws {
        if !(minTyping...max).contains(string.count) {
            throw error
        }
    }
}
