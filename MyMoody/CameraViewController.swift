//
//  CameraViewController.swift
//  MyMoody
//
//  Created by TaoTao on 2020/1/7.
//  Copyright © 2020 TaoTao. All rights reserved.
//

import UIKit


protocol CameraViewControllerDelegate: class {
    func didCapture(_ image: UIImage)
}

class CameraViewController: UIViewController {
    
    @IBOutlet weak var cameraView: CameraView?
    
    weak var delegate: CameraViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        session = CaptureSession(delegate: self)
        #if !IOS_SIMULATOR
        cameraView?.setup(for: session.createPreviewLayer())
        #endif
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(snap))
        cameraView?.addGestureRecognizer(recognizer)
        updateAuthorizationStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        session.start()
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        session.stop()
    }
    
    @objc func snap() {
        #if IOS_SIMULATOR
        self.showImagePicker()
        #else
        session.captureImage()
        #endif
    }
    
    fileprivate var session: CaptureSession!
    fileprivate var imagePicker: UIImagePickerController?
    fileprivate var readyToSnap: Bool {
        return session.isAuthorized
    }
    
    fileprivate func updateAuthorizationStatus() {
        cameraView?.authorized = readyToSnap
    }
    
    fileprivate func showImagePicker() {
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        present(imagePicker!, animated: true, completion: nil)
    }
    
}

extension CameraViewController: CaptureSessionDelegate {
    func captureSessionDidChangeAuthorizationStatus(authorized: Bool) {
        updateAuthorizationStatus()
    }
    
    func captureSessionDidCapture(_ image: UIImage?) {
        guard let image = image else { return }
        delegate.didCapture(image)
    }
}

extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            delegate.didCapture(image)
        }
        dismiss(animated: true, completion: nil)
        imagePicker = nil
    }
}
