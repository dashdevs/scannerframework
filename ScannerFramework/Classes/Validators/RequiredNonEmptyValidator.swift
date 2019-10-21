//
//  RequiredNonEmptyValidator.swift
//  Dozens
//
//  Created by Yuriy Gavrilenko on 7/30/18.
//

import Foundation

public class RequiredNonEmptyValidator: Validator {
    override var error: ValidationError {
        return .empty
    }
    
    public override func validate(string: String) throws {
        if string.replacingOccurrences(of: " ", with: "").isEmpty {
            throw error
        }
    }
}
