//
//  DecimalValidator.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/9/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

public class DecimalValidator: RegexValidator {
    private var _regex = "^[0-9]+([.,][0-9]+)?$"
    private var _typingRegex = "^[0-9]+([.,]([0-9]+|[0-9]*))?$"
    
    override var regex: String {
        return _regex
    }
    
    override var typingRegex: String {
        return _typingRegex
    }
    
    override var error: ValidationError {
        return .unknown
    }
    
    convenience init(maxDecimalCount: Int?) {
        self.init()
        guard let maxDecimalCount = maxDecimalCount else { return }
        _regex = "^[0-9]+([.,][0-9]{1,\(maxDecimalCount)})?$"
        _typingRegex = "^[0-9]+([.,]([0-9]{1,\(maxDecimalCount)}|[0-9]{0,\(maxDecimalCount)}))?$"
    }
    
    override func validate(string: String) throws {
        let validationPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        if !validationPredicate.evaluate(with: string) {
            throw error
        }
    }
    
    public override func validateTyping(string: String) throws {
        let validationPredicate = NSPredicate(format: "SELF MATCHES %@", typingRegex)
        if !validationPredicate.evaluate(with: string) {
            throw error
        }
    }
}
