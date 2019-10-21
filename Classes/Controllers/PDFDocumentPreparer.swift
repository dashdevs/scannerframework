//
//  PDFDocumentPreparer.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/20/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

public class PDFDocumentPreparer {
    private struct Constants {
        static let imagePadding: CGFloat = 20.0
    }
    
    private static func makePDFFrom(view: UIView) -> Data? {
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, view.bounds, nil)
        UIGraphicsBeginPDFPage()
        guard let pdfContext = UIGraphicsGetCurrentContext() else { return nil }
        view.layer.render(in: pdfContext)
        UIGraphicsEndPDFContext()
        
        return (pdfData as Data)
    }
    
    public static func createPDF(for images: [UIImage]) -> Data? {
        guard let image = images.first else { return nil }
        let viewHeight = (image.size.height + Constants.imagePadding) * CGFloat(images.count)
        let viewForPDF = UIView(frame: CGRect(origin: .zero, size: CGSize(width: image.size.width, height: viewHeight)))
        var imageYPosition: CGFloat = 0
        viewForPDF.backgroundColor = .clear
        images.forEach {
            let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: imageYPosition), size: $0.size))
            imageView.image = $0
            viewForPDF.addSubview(imageView)
            imageYPosition += $0.size.height + Constants.imagePadding
        }
        
        return makePDFFrom(view: viewForPDF)
    }
}
