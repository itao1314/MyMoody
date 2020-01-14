//
//  CaptureSession.swift
//  MyMoody
//
//  Created by TaoTao on 2020/1/8.
//  Copyright © 2020 TaoTao. All rights reserved.
//

import AVFoundation
import UIKit

protocol CaptureSessionDelegate: class {
    func captureSessionDidChangeAuthorizationStatus(authorized: Bool)
    func captureSessionDidCapture(_ image: UIImage?)
}

class CaptureSession: NSObject {
    var isAuthorized: Bool {
        return AVCaptureDevice.authorizationStatus(for: .video) == .authorized
    }
    
    var isReady: Bool {
        return !session.inputs.isEmpty
    }
    
    init(delegate: CaptureSessionDelegate) {
        self.delegate = delegate
        super.init()
        if isAuthorized {
            setup()
        } else {
            requestAuthorization()
        }
    }
    
    func start() {
        #if !IOS_SIMULATOR
        queue.async {
            self.session.startRunning()
        }
        #endif
    }
    
    func stop() {
        #if !IOS_SIMULATOR
        queue.async {
            self.session.stopRunning()
        }
        #endif
    }
    
    func createPreviewLayer() -> AVCaptureVideoPreviewLayer {
        return AVCaptureVideoPreviewLayer(session: session)
    }
    
    func captureImage() {
        queue.async {
            self.photoOutPut.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        }
    }
    
    fileprivate let session = AVCaptureSession()
    fileprivate var photoOutPut: AVCapturePhotoOutput!
    fileprivate let queue = DispatchQueue(label: "moody.capture-queue", attributes: [])
    fileprivate weak var delegate: CaptureSessionDelegate!
    
    fileprivate func setup() {
        #if !IOS_SIMULATOR
        session.sessionPreset = AVCaptureSession.Preset.photo
        let discovery = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back)
        if let camera = discovery.devices.first {
            let input = try! AVCaptureDeviceInput(device: camera)
            if session.canAddInput(input) {
                session.addInput(input)
            }
        }
        photoOutPut = AVCapturePhotoOutput()
        if session.canAddOutput(photoOutPut) {
            session.addOutput(photoOutPut)
        }
        #endif
    }
    
    fileprivate func requestAuthorization() {
        AVCaptureDevice.requestAccess(for: .video) { authorized in
            DispatchQueue.main.async {
                self.delegate.captureSessionDidChangeAuthorizationStatus(authorized: authorized)
                guard authorized else { return }
                self.setup()
            }
        }
    }
}

extension CaptureSession: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        let image = photo.fileDataRepresentation().flatMap(UIImage.init)
        DispatchQueue.main.async {
            self.delegate.captureSessionDidCapture(image)
        }
    }
    
}
