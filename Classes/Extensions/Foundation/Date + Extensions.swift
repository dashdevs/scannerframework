//
//  Date + Extensions.swift
//  GoodsScanner
//
//  Created by Sergei Striuk on 8/22/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

extension Date {
    public static var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date())!
    }
    
    public var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    public var endOfDay: Date {
        return Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: self)!
    }
}
