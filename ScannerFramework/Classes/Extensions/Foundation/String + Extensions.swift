//
//  String + Extensions.swift
//  GoodsScanner
//
//  Created by Sergei Striuk on 8/14/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

extension String {
    func distanceToNextDigit(from index: Int, toEnd direction: Bool) -> Int {
        guard index < count else { return 0 }
        let substring = direction ? suffix(count - index) : prefix(index).reversed()
        let endIndex = substring.firstIndex(where: { $0.isNumber })
        
        return substring.distance(from: substring.startIndex, to: endIndex ?? substring.startIndex)
    }
}

extension String {
    func toPhoneNumber() -> String {
        switch count {
        case 0...3:
            return replacingOccurrences(of: "(\\d{1,2})", with: "$1", options: .regularExpression)
        case 4...6:
            return replacingOccurrences(of: "(\\d{2})(\\d{1,3})", with: "$1 ($2", options: .regularExpression)
        case 7...9:
            return replacingOccurrences(of: "(\\d{2})(\\d{3})(\\d{1,3})", with: "$1 ($2) $3", options: .regularExpression)
        case 10...11:
            return replacingOccurrences(of: "(\\d{2})(\\d{3})(\\d{3})(\\d{1,2})", with: "$1 ($2) $3-$4", options: .regularExpression)
        case 12...13:
            return replacingOccurrences(of: "(\\d{2})(\\d{3})(\\d{3})(\\d{2})(\\d{1,2})", with: "$1 ($2) $3-$4-$5", options: .regularExpression)
        default:
            return String(prefix(13)).toPhoneNumber()
        }
    }
    
    func fromPhoneNumber() -> String {
        return self.filter("+01234567890".contains)
    }
}

// MARK: Email validation

extension String {
    func validateWith(rules: [ValidationRule]) throws {
        try Validator.validate(string: self, withRules: rules)
    }
}
