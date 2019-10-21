//
//  IndexPath + Extensions.swift
//  GoodsScanner
//
//  Created by Sergei Striuk on 8/23/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

extension IndexPath {
    public var nextRowIndexPath: IndexPath {
        return IndexPath(row: row + 1, section: section)
    }
    
    public var previousRowIndexPath: IndexPath? {
        return row > 0 ? IndexPath(row: row - 1, section: section) : nil
    }
}
