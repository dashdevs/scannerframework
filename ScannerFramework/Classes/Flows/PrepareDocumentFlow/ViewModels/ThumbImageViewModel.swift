//
//  ThumbImageViewModel.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/12/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

class ThumbImageViewModel {
    private struct Constants {
        static let compressionQuality: CGFloat = 0.2
    }
    let image: UIImage
    var isChecked: Bool = true
    
    init(image: UIImage) {
        guard let jpegImage = image.jpegData(compressionQuality: Constants.compressionQuality),
            let compressedImage = UIImage(data: jpegImage) else {
            self.image = image
            return
        }
        self.image = compressedImage
    }
}
