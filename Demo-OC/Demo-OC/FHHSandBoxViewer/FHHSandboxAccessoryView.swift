//
//  SandboxAccessoryView.swift
//  StudentLive
//
//  Created by hefanghui on 2018/4/26.
//  Copyright © 2018年 hqyxedu. All rights reserved.
//

import UIKit

@objc protocol FHHSandboxAccessoryViewDelegate: NSObjectProtocol {
    func SandboxAccessory(_: FHHSandboxAccessoryView, didClickSharedButton: UIButton)
}

@objc class FHHSandboxAccessoryView: UIView {

    // MARK:Properties
    weak var delegate: FHHSandboxAccessoryViewDelegate?

    // MARK:Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configOwoProperties()
        self.configSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        FHHLog("deinit")
    }
    
    // MARK:Functions
    private func configOwoProperties() {
        self.backgroundColor = fhh_rgb(248, 248, 248)
        self.layer.shadowColor = fhh_rgb(204, 204, 204).cgColor
        self.layer.shadowOpacity = 0.25
        self.layer.shadowRadius = 1.5
    }
    
    // MARK:HandleViews
    func refreshShareButton(enable: Bool) {
        shareButton.isEnabled = enable
    }
   
    private func configSubViews() {
        self.addSubview(self.shareButton)
        
        shareButton.sizeToFit()
        shareButton.fhh_centerX = self.fhh_width * 0.5
        shareButton.fhh_centerY = self.fhh_height * 0.5
    }
    
    // MARK:HandleEvents
    @objc private func shareButtonDidClick() {
        if delegate != nil {
            delegate?.SandboxAccessory(self, didClickSharedButton: shareButton)
        }
    }
    
    // MARK:LazyLoads
    private lazy var shareButton: UIButton = {
        let button = UIButton.init()
        button.addTarget(self, action: #selector(shareButtonDidClick), for: .touchUpInside)
        button.setTitle("share", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.setTitleColor(UIColor.gray, for: .disabled)
        button.setTitleColor(fhh_rgb(75, 172, 255), for: .highlighted)
        
        return button
    }()
}
