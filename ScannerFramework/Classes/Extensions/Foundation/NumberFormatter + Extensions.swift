//
//  NumberFormatter + Extensions.swift
//  GoodsScanner
//
//  Created by Sergei Striuk on 8/28/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

public class AppCountFormatter: NumberFormatter {
    private struct Constants {
        static let defaultValue = "0"
        static let maximumFractionDigits = 10
    }
    
    override init() {
        super.init()
        numberStyle = .decimal
        locale = Locale(identifier: "uk_UA")
        maximumFractionDigits = Constants.maximumFractionDigits
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func string(from number: NSNumber?) -> String {
        guard let number = number else { return Constants.defaultValue }
        return super.string(from: number) ?? Constants.defaultValue
    }
}

public class SpellCurrencyFormatter: NumberFormatter {
    private struct Constants {
        static let precision: Int = 2
        static let fractConversionCoeff = NSDecimalNumber(decimal: pow(10, Constants.precision))
        static let locale = Locale(identifier: "uk_UA")
        static let bundle = Bundle(for: SpellCurrencyFormatter.self)
        static let hrnSpellFormat = NSLocalizedString("hryvna count", tableName: nil, bundle: bundle, comment: "")
        static let centSpellFormat = NSLocalizedString("cent count", tableName: nil, bundle: bundle, comment: "")
    }
    
    override init() {
        super.init()
        numberStyle = .spellOut
        locale = Constants.locale
        minimumFractionDigits = Constants.precision
        maximumFractionDigits = Constants.precision
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func hrhSpell(for value: NSDecimalNumber) -> String {
        return String(format: Constants.hrnSpellFormat, locale: locale, value)
    }
    
    private func centSpell(for value: NSDecimalNumber) -> String {
        return String(format: Constants.centSpellFormat, locale: locale, value)
    }
    
    public override func string(from number: NSNumber?) -> String {
        var decimalResult: Decimal = 0
        var decimal = (number ?? 0).decimalValue
        NSDecimalRound(&decimalResult, &decimal, Constants.precision, .plain)
        let number = NSDecimalNumber(decimal: decimalResult)
        let intNumber = NSDecimalNumber(value: number.int32Value)
        let fracPart = number.subtracting(intNumber).multiplying(by: Constants.fractConversionCoeff).int32Value
        let fracNumber = NSDecimalNumber(value: fracPart)
        let intSpell = super.string(from: intNumber) ?? ""
        let fracSpell = super.string(from: fracNumber) ?? ""
        var result = "\(intSpell) \(hrhSpell(for: intNumber)) \(fracSpell) \(centSpell(for: fracNumber))"
        result = result.replacingOccurrences(of: L10n.oneUkMale, with: L10n.oneUkFemale)
            .replacingOccurrences(of: L10n.twoUkMale, with: L10n.twoUkFemale)
        return result
    }
}

extension NumberFormatter {
    static var uahCurrencySymbol: String = "грн"
    
    public static var uahDecimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "uk_UA")
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.currencySymbol = NumberFormatter.uahCurrencySymbol
        return formatter
    }()
    
    public static var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "uk_UA")
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.currencySymbol = ""
        formatter.currencyCode = ""
        formatter.internationalCurrencySymbol = ""
        return formatter
    }()
    
    public static var spellCurrencyFormatter = SpellCurrencyFormatter()
    public static var countFormatter = AppCountFormatter()
}
