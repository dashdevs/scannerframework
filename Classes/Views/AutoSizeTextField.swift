//
//  AutoSizeTextField.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/16/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

public class AutoSizeTextField: UITextField {
    open override var intrinsicContentSize: CGSize {
        if #available(iOS 11.0, *) {
            return super.intrinsicContentSize
        } else {
            guard isEditing, let font = font else { return super.intrinsicContentSize }
            let string = (text ?? "") as NSString
            return string.size(withAttributes: [.font: font])
        }
    }
}
