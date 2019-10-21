//
//  TimerFormatter.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/20/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

class TimerFormatter {
    private struct Constants {
        static let secondsInMinute: TimeInterval = 60.0
        static let defaultValue = "0:00"
    }
    
    private let formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    func string(from timeInterval: TimeInterval) -> String {
        let postfix = " " + (timeInterval >= Constants.secondsInMinute ? L10n.minutesTitle : L10n.secondsTitle)
        return (formatter.string(from: timeInterval) ?? Constants.defaultValue) + postfix
    }
}
