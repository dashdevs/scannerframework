//
//  UIScreen + Extensions.swift
//  GoodsScanner
//
//  Created by Sergei Striuk on 8/15/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

// MARK: - Adaptive layout: Provides relative dimensions and utilities for screen width & height

@objc extension UIScreen {
    // MARK: - Default screen dimensions, specified in design (iPhone 8)
    
    private static var designWidth: CGFloat {
        return 375.0
    }
    
    private static var designHeight: CGFloat {
        return 667.0
    }
    
    // MARK: - Properties
    
    public var isSmallScreen: Bool {
        return UIScreen.main.bounds.width <= 320.0
    }
    
    /// i.e. actual screen width, divided by the width in design.
    var relativeWidthMultiplier: CGFloat {
        return bounds.width / UIScreen.designWidth
    }
    
    /// i.e. actual screen height, divided by the height in design.
    var relativeHeightMultiplier: CGFloat {
        return bounds.height / UIScreen.designHeight
    }
    
    // MARK: - Public methods
    
    /// Calculates relative dimension value for baseWidth.
    ///
    /// - Parameters:
    ///   - baseWidth: Basic width value.
    ///   - limitedToMax: Defines whether the result should be limited to baseDimension as a maximum value.
    /// - Returns: Relative width value.
    public func getRelativeWidth(for baseWidth: CGFloat, limitedToMax: Bool = true) -> CGFloat {
        return getRelativeDimension(for: baseWidth, multiplier: relativeWidthMultiplier, limitedToMax: limitedToMax)
    }
    
    /// Calculates relative dimension value for baseHeight.
    ///
    /// - Parameters:
    ///   - baseHeight: Basic height value.
    ///   - limitedToMax: Defines whether the result should be limited to baseDimension as a maximum value.
    /// - Returns: Relative height value.
    public func getRelativeHeight(for baseHeight: CGFloat, limitedToMax: Bool = true) -> CGFloat {
        return getRelativeDimension(for: baseHeight, multiplier: relativeHeightMultiplier, limitedToMax: limitedToMax)
    }
    
    // MARK: - Private methods
    
    /// Calculates relative value of screen dimension,
    /// from baseDimension and relative multiplier and
    /// also can apply limitation to baseDimension value.
    ///
    /// - Parameters:
    ///   - baseDimension: Basic value of screen dimension.
    ///   - multiplier: Relative multiplier.
    ///   - limitedToBase: Defines whether the result should be limited to baseDimension as a maximum value.
    /// - Returns: Relative value of screen dimension.
    private func getRelativeDimension(for baseDimension: CGFloat, multiplier: CGFloat, limitedToMax: Bool) -> CGFloat {
        let relativeDimension = baseDimension * multiplier
        return limitedToMax ? min(baseDimension, relativeDimension) : relativeDimension
    }
}
