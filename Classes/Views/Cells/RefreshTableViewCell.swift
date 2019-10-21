//
//  RefreshTableViewCell.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 8/28/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

public class RefreshTableViewCell: UITableViewCell {
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    public static let reuseIdentifier = "refreshCellReuseIdentifier"
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
    
    public func startAnimating() {
        activityIndicator.startAnimating()
    }
}

extension UINib {
    public static var refreshCellNib: UINib {
        let bundle = Bundle(for: RefreshTableViewCell.self)
        return UINib(nibName: "RefreshTableViewCell", bundle: bundle)
    }
}
