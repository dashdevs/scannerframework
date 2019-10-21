//
//  RegexValidator.swift
//  Dozens
//
//  Created by Yuriy Gavrilenko on 7/30/18.
//

import Foundation

public class RegexValidator: TypingValidator {
    var regex: String {
        return "^.*$"
    }
    
    var typingRegex: String {
        return "^.*$"
    }
    
    override var error: ValidationError {
        return .unknown
    }
    
    override func validate(string: String) throws {
        let validationPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        if !validationPredicate.evaluate(with: string) {
            throw error
        }
    }
    
    public func validateTyping(string: String) throws {
        let validationPredicate = NSPredicate(format: "SELF MATCHES %@", typingRegex)
        if !validationPredicate.evaluate(with: string) {
            throw error
        }
    }
}
