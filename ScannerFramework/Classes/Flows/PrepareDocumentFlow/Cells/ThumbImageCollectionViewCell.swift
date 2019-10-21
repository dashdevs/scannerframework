//
//  ThumbImageCollectionViewCell.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/12/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

class ThumbImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var checkedImageView: UIImageView!
    
    private var onCheckChange: ((Bool) -> Void)!
    
    private var isChecked: Bool = false {
        didSet {
            checkedImageView.isHidden = !isChecked
        }
    }
    
    @IBAction func onCheckTap(_ sender: Any) {
        isChecked = !isChecked
        onCheckChange?(isChecked)
    }
    
    func configure(with viewModel: ThumbImageViewModel, onCheckChange: @escaping ((Bool) -> Void)) {
        imageView.image = viewModel.image
        isChecked = viewModel.isChecked
        self.onCheckChange = onCheckChange
    }
}
