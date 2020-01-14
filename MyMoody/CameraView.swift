//
//  CameraView.swift
//  MyMoody
//
//  Created by TaoTao on 2020/1/7.
//  Copyright © 2020 TaoTao. All rights reserved.
//

import UIKit
import AVFoundation

class CameraView: UIView {
    
    @IBOutlet weak var label: UILabel!
    
    var authorized: Bool = false {
        didSet {
            label.text = authorized ? "Tap to Capture Mood" : "Moody needs camera & location access"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(for previewLayer: AVCaptureVideoPreviewLayer) {
        previewLayer.videoGravity = .resizeAspectFill
        layer.insertSublayer(previewLayer, at: 0)
        self.previewLayer = previewLayer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer?.frame = bounds
    }
    
    fileprivate var previewLayer: AVCaptureVideoPreviewLayer?
    
    fileprivate func setup() {
        backgroundColor = .black
    }
    
}
