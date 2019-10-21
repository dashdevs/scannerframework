//
//  Validator.swift
//  Dozens
//
//  Created by Yuriy Gavrilenko on 7/27/18.
//

import Foundation

enum ValidationError: Error, LocalizedError {
    case unknown
    case email
    case length
    case numeric
    case phoneCharacters
    case empty
    case decimal
    
    var errorDescription: String? {
        switch self {
        case .email:
            return L10n.errorWrongEmail
            
        default:
            return "Unknown validation error"
        }
    }
}

enum ValidationRule {
    case email
    case length(min: Int, max: Int, typingMin: Int)
    case numeric
    case phoneCharacters
    case nonEmpty
    case decimal(maxDecimal: Int?)
    
    var validator: Validator {
        switch self {
        case .email:
            return EmailValidator()
        case .length(min: let minValue, max: let maxValue, typingMin: let typingMinValue):
            return LengthValidator(minLength: minValue, maxLength: maxValue, minTypingLength: typingMinValue)
        case .numeric:
            return NumericValidator()
        case .phoneCharacters:
            return PhoneCharactersValidator()
        case .nonEmpty:
            return RequiredNonEmptyValidator()
        case .decimal(maxDecimal: let maxDecimalCount):
            return DecimalValidator(maxDecimalCount: maxDecimalCount)
        }
    }
}

public class Validator: NSObject {
    var error: ValidationError {
        return .unknown
    }
    
    func validate(string: String) throws {
        throw error
    }
    
    static func validate(string: String, withRules rules: [ValidationRule]) throws {
        let validators = rules.map { $0.validator }
        try ValidatorGroup(validators: validators).validate(string: string)
    }
}

@objc public protocol TypingValidatorProtocol {
    func validateTyping(string: String) throws
}

public typealias TypingValidator = (Validator & TypingValidatorProtocol)

/* Validation example
 
 let someString = "Some string"
 
 do {
 try someString.validateWith(rules: [.alphabetic, .length(min: 1, max: 7)])
 } catch is ValidationError {
 print("Damn")
 }
 
 do {
 try someString.validateWith(rules: [.required, .numeric, .match(value: "Some another string")])
 } catch ValidationError.required {
 print("Field is required")
 } catch ValidationError.numeric {
 print("Incorrect characters")
 } catch ValidationError.match {
 print("Strings doesn't match")
 }
 */
