//
//  TransparentNavigationBar.swift
//  GoodsScanner
//
//  Created by Sergei Striuk on 8/16/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

class TransparentNavigationBar: UINavigationBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        becomeTransparent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        becomeTransparent()
    }
    
    private func becomeTransparent() {
        setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        shadowImage = UIImage()
        isTranslucent = true
    }
}
