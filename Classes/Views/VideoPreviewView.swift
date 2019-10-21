//
//  VideoPreviewView.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/11/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import AVFoundation
import UIKit

public class VideoPreviewView: UIView {
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        videoPreviewLayer.videoGravity = .resizeAspectFill
    }
    
    public override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    public var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
}
