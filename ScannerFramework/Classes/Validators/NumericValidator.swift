//
//  NumericValidator.swift
//  Dozens
//
//  Created by Yuriy Gavrilenko on 7/30/18.
//

import Foundation

final class NumericValidator: RegexValidator {
    override var regex: String {
        return "^[0-9]*$"
    }
    
    override var typingRegex: String {
        return regex
    }
    
    override var error: ValidationError {
        return .numeric
    }
}
