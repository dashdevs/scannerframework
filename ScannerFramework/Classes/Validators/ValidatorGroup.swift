//
//  ValidatorGroup.swift
//  Dozens
//
//  Created by Yuriy Gavrilenko on 7/30/18.
//

import Foundation

final class ValidatorGroup: Validator {
    override var error: ValidationError {
        return .unknown
    }
    
    var validators: [Validator]
    init(validators: [Validator]) {
        self.validators = validators
    }
    
    override func validate(string: String) throws {
        for validator in validators {
            try validator.validate(string: string)
        }
    }
}
