//
//  PhoneCharactersValidator.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/23/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

final class PhoneCharactersValidator: RegexValidator {
    override var regex: String {
        return "^[+0-9]*$"
    }
    
    override var error: ValidationError {
        return .phoneCharacters
    }
}
