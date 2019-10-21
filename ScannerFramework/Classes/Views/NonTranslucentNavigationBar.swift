//
//  NonTranslucentNavigationBar.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/12/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

class NonTranslucentNavigationBar: UINavigationBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        isTranslucent = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isTranslucent = false
    }
}
