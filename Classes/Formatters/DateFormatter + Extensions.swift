//
//  DateFormatter + Extensions.swift
//  GoodsScanner
//
//  Created by Sergei Striuk on 8/28/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

extension DateFormatter {
    public static var dottedYearMonthDayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        return formatter
    }()
    
    public static var fullDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "uk_UA")
        return formatter
    }()
}
