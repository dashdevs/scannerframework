//
//  EmailValidator.swift
//  Dozens
//
//  Created by Yuriy Gavrilenko on 7/30/18.
//

import Foundation

final class EmailValidator: RegexValidator {
    override var regex: String {
        return """
        (?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}\
        ~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\\
        x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-\
        z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5\
        ]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-\
        9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\
        -\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])
        """
    }
    
    override var error: ValidationError {
        return .email
    }
    
    override func validate(string: String) throws {
        let components = string.split(separator: " ")
        if components.count == 1, let email = components.first {
            try super.validate(string: String(email))
        } else {
            throw error
        }
    }
}
