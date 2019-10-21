//
//  StringStylzation.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/29/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import CoreGraphics
import Foundation

public class StringStylization: NSObject {
    @IBInspectable
    var letterSpacing: CGFloat = 0.93
    
    public func styleWithLetterSpacing(_ text: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
}
