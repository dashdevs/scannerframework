//
//  CameraViewController.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/11/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import AVFoundation
import UIKit

class CameraViewController: UIViewController, RequestVideoPermission {
    @IBOutlet private weak var cancelButton: UIBarButtonItem!
    @IBOutlet private var videoPreviewView: VideoPreviewView!
    @IBOutlet private weak var activityView: UIActivityIndicatorView!
    @IBOutlet private weak var photoButton: UIButton!
    @IBOutlet private weak var activityContainerView: UIView!
    
    var onPhotoCaptured: ((UIImage) -> Void)?
    var requestDescription: String = L10n.photoDescription
    
    private let captureSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: AVCaptureSession.self.description(), attributes: [], target: nil)
    private var photoOutput: Any?
    
    private var isPhotoEnabled = true {
        didSet {
            photoButton.isUserInteractionEnabled = isPhotoEnabled
            activityContainerView.isHidden = isPhotoEnabled
            isPhotoEnabled ? activityView.stopAnimating() : activityView.startAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localize()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestVideoPermission {
            self.sessionQueue.async {
                self.captureSession.startRunning()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.sessionQueue.async {
            self.captureSession.stopRunning()
        }
    }
    
    // MARK: - Private
    
    private func setup() {
        videoPreviewView.videoPreviewLayer.session = captureSession
        sessionQueue.async {
            self.configureCaptureSession()
        }
    }
    
    private func configureCaptureSession() {
        guard let videoDevice = AVCaptureDevice.default(for: .video),
            let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice),
            captureSession.canAddInput(videoDeviceInput) else {
            return
        }
        captureSession.beginConfiguration()
        captureSession.sessionPreset = .photo
        captureSession.addInput(videoDeviceInput)
        
        if #available(iOS 11.0, *) {
            let photoOutput = AVCapturePhotoOutput()
            if captureSession.canAddOutput(photoOutput) {
                captureSession.addOutput(photoOutput)
                self.photoOutput = photoOutput
            }
        } else {
            let photoOutput = AVCaptureStillImageOutput()
            if captureSession.canAddOutput(photoOutput) {
                captureSession.addOutput(photoOutput)
                self.photoOutput = photoOutput
            }
        }
        
        captureSession.commitConfiguration()
    }
    
    private func onSuccess(_ image: UIImage) {
        isPhotoEnabled = true
        dismiss(animated: false, completion: nil)
        onPhotoCaptured?(image)
    }
    
    // MARK: - Actions
    
    @IBAction func onCancelTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPhotoTap(_ sender: Any) {
        if #available(iOS 11.0, *) {
            guard let photoOutput = photoOutput as? AVCapturePhotoOutput else { return }
            isPhotoEnabled = false
            let config = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
            config.isHighResolutionPhotoEnabled = false
            photoOutput.capturePhoto(with: config, delegate: self)
        } else {
            guard let photoOutput = (photoOutput as? AVCaptureStillImageOutput),
                let connection = photoOutput.connection(with: .video) else { return }
            isPhotoEnabled = false
            photoOutput.captureStillImageAsynchronously(from: connection) { [weak self] sampleBuffer, _ in
                DispatchQueue.main.async {
                    self?.isPhotoEnabled = true
                    guard let sampleBuffer = sampleBuffer,
                        let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer),
                        let image = UIImage(data: imageData) else { return }
                    
                    self?.onSuccess(image)
                }
            }
        }
    }
}

extension CameraViewController: Localizable {
    func localize() {
        title = L10n.cameraTitle
        cancelButton.title = L10n.cancelTitle
    }
}

@available(iOS 11.0, *)
extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(), let image = UIImage(data: imageData) else {
            isPhotoEnabled = true
            return
        }
        DispatchQueue.main.async {
            self.onSuccess(image)
        }
    }
}
