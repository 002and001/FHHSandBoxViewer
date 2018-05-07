//
//  UIViewController+FHHCustomerNavBar.swift
//  FHHSandBoxManager
//
//  Created by hefanghui on 2018/4/26.
//  Copyright © 2018年 hefanghui. All rights reserved.
//

import UIKit

private var kNavigationBarKey: String = "kFHHNavigationBarKey"
private var kNavMiddleButtonKey: String = "kFHHNavMiddleButtonKey"
private var kNavLeftButtonKey: String = "kFHHNavLeftButtonKey"
private var kNavRightButtonKey: String = "kFHHNavLeftButtonKey"
private var kEnterType: String = "kFHHEnterType"
private let kMargin: CGFloat = 15.0

@objc enum FHHEnterType: NSInteger {
    case push = 0
    case present = 1
}

@objc extension UIViewController {
    
    @objc public func fhh_setNavigationBar(title: String?) {
        self.fhh_setNavigationBar(title: title, navLeftButtonIcon: nil, navRightButtonIcon: nil, navRightButtonTitle: nil)
    }
    
    @objc public func fhh_setNavigationBar(title: String?, navLeftButtonIcon: String?) {
        self.fhh_setNavigationBar(title: title, navLeftButtonIcon: navLeftButtonIcon, navRightButtonIcon: nil, navRightButtonTitle: nil)
    }
    
    @objc public func fhh_setNavigationBar(title: String?, navLeftButtonIcon: String?, navRightButtonTitle: String?) {
        self.fhh_setNavigationBar(title: title, navLeftButtonIcon: navLeftButtonIcon, navRightButtonIcon: nil, navRightButtonTitle: navRightButtonTitle)
    }
    
    @objc public func fhh_setNavigationBar(title: String?, navLeftButtonIcon: String?, navRightButtonIcon: String?) {
        self.fhh_setNavigationBar(title: title, navLeftButtonIcon: navLeftButtonIcon, navRightButtonIcon: navRightButtonIcon, navRightButtonTitle: nil)
    }
    
    @objc public func fhh_setNavigationBar(title: String?, navLeftButtonIcon: String?, navRightButtonIcon: String?, navRightButtonTitle: String?) {
        self.fhh_configNavigationBar()
        self.fhh_configNavLeftButton(navLeftButtonIcon: navLeftButtonIcon)
        self.fhh_configNavRightButton(navRightButtonTitle: navRightButtonTitle, navRightButtonIcon: navRightButtonIcon)
        self.fhh_configNavMiddleButton(title: title)
        self.fhh_configBottomSepImageView()
    }
    
    // MARK:HandleViews
    func fhh_configNavigationBar() {
        if fhh_navigationBar != nil {
            fhh_navigationBar?.removeFromSuperview()
        }
        let frame = CGRect.init(x: 0, y: 0, width: UIDevice.fhh_kScreenW(), height: UIDevice.fhh_kNavigationBarHeight())
        fhh_navigationBar = UIView.init(frame: frame)
        view.addSubview(fhh_navigationBar!)
        fhh_navigationBar?.backgroundColor = UIColor.init(red: 250 / 255.0, green: 250 / 255.0, blue: 250 / 255.0, alpha: 1.0)
    }
    
    func fhh_configNavLeftButton(navLeftButtonIcon: String?) {
        self.fhh_initLeftButton(navLeftButtonIcon: navLeftButtonIcon)
        self.fhh_configLeftButtonEdgeInsets(navLeftButtonIcon: navLeftButtonIcon)
    }
    
    private func fhh_initLeftButton(navLeftButtonIcon: String?) {
        fhh_navLeftButton = UIButton()
        fhh_navigationBar?.addSubview(fhh_navLeftButton!)
        fhh_navLeftButton?.contentHorizontalAlignment = .left
        if navLeftButtonIcon == "" || navLeftButtonIcon == nil {
            fhh_navLeftButton?.setTitle("back", for: .normal)
            fhh_navLeftButton?.setTitleColor(fhh_rgb(40, 40, 40), for: .normal)
            fhh_navLeftButton?.setTitleColor(fhh_rgb(179, 186, 191), for: .highlighted)
        } else {
            fhh_navLeftButton?.setImage(UIImage.init(named: navLeftButtonIcon!), for: .normal)
        }
        fhh_navLeftButton?.addTarget(self, action: #selector(fhh_clickLeftNavButton), for: .touchUpInside)
        let frame = CGRect.init(x: 0, y: 0, width: 50, height: UIDevice.fhh_kNavigationBarHeight())
        fhh_navLeftButton?.frame = frame
        fhh_navLeftButton?.fhh_bottom = (self.fhh_navigationBar?.fhh_height)!
    }
    
    private func fhh_configLeftButtonEdgeInsets(navLeftButtonIcon: String?) {
        if navLeftButtonIcon != nil && navLeftButtonIcon != "" {
            fhh_navLeftButton?.imageEdgeInsets = UIEdgeInsetsMake(20, kMargin, 0, 0)
        } else {
            fhh_navLeftButton?.titleEdgeInsets = UIEdgeInsetsMake(20, kMargin, 0, -kMargin)
        }
        
    }
    
    private func fhh_configNavRightButton(navRightButtonTitle: String?, navRightButtonIcon: String?) {
        let isNavRightButtonTitleEmpty = (navRightButtonTitle == nil || navRightButtonTitle == "")
        let isNavRightButtonIconEmpty = (navRightButtonIcon == nil || navRightButtonIcon == "")
        if (isNavRightButtonTitleEmpty == false) ||
            (isNavRightButtonIconEmpty == false) {
            self.fhh_initNavRightButton(navRightButtonTitle: navRightButtonTitle, navRightButtonIcon: navRightButtonIcon)
            self.fhh_reConfigNavRightButton()
            self.fhh_configRightButtonEdgeInsets()
        }
    }
    
    private func fhh_initNavRightButton(navRightButtonTitle: String?, navRightButtonIcon: String?) {
        fhh_navRightButton = UIButton()
        fhh_navigationBar?.addSubview(fhh_navRightButton!)
        fhh_navRightButton?.contentHorizontalAlignment = .left
        fhh_navRightButton?.setTitleColor(fhh_rgb(58, 58, 58), for: .normal)
        fhh_navRightButton?.setTitleColor(fhh_rgb(179, 186, 191), for: .highlighted)
        let isNavRightButtonTitleEmpty = (navRightButtonTitle == nil || navRightButtonTitle == "")
        let isNavRightButtonIconEmpty = (navRightButtonIcon == nil || navRightButtonIcon == "")
        if isNavRightButtonTitleEmpty == false {
            fhh_navRightButton?.setTitle(navRightButtonTitle, for: .normal)
        }
        if isNavRightButtonIconEmpty == false {
            fhh_navRightButton?.setImage(UIImage.init(named: navRightButtonIcon!), for: .normal)
        }
    }
    
    private func fhh_configRightButtonEdgeInsets() {
        let imageSize = fhh_navRightButton?.imageView?.fhh_size
        let titleSize = fhh_navRightButton?.titleLabel?.fhh_size
        let imageLeftInset = (fhh_navRightButton?.fhh_width)! - (imageSize?.width)! - kMargin
        let titleLeftInset = (fhh_navRightButton?.fhh_width)! - (titleSize?.width)! - kMargin + 2
        
        fhh_navRightButton?.imageEdgeInsets = UIEdgeInsetsMake(0, imageLeftInset, 0, -imageLeftInset)
        fhh_navRightButton?.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, titleLeftInset)
    }
    
    @objc func fhh_reConfigNavRightButton() {
        if fhh_navRightButton?.currentBackgroundImage == nil {
            fhh_navRightButton?.sizeToFit()
            fhh_navRightButton?.fhh_width = (fhh_navRightButton?.fhh_width)! + kMargin
            fhh_navRightButton?.fhh_height = 44
            if (fhh_navRightButton?.fhh_height)! < CGFloat(40.0) {
                fhh_navRightButton?.fhh_height = 40
            }
            fhh_navRightButton?.fhh_right = (fhh_navigationBar?.fhh_right)!
        } else {
            fhh_navRightButton?.fhh_right = (fhh_navigationBar?.fhh_right)! - kMargin
        }
        fhh_navRightButton?.fhh_centerY = (fhh_navLeftButton?.fhh_centerY)! + 10
    }
    
    private func fhh_configNavMiddleButton(title: String?) {
        if title != nil && title != "" {
            self.fhh_initNavMiddleButton(title: title!)
            self.fhh_reConfigNavMiddleButton()
        }
    }
    
    private func fhh_initNavMiddleButton(title: String) {
        fhh_navMiddleButton = UIButton()
        fhh_navigationBar?.addSubview(fhh_navMiddleButton!)
        fhh_navMiddleButton?.titleLabel?.lineBreakMode = .byTruncatingTail
        fhh_navMiddleButton?.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        fhh_navMiddleButton?.setTitle(title, for: .normal)
        fhh_navMiddleButton?.setTitleColor(fhh_rgb(55, 62, 68), for: .normal)
    }
    
    @objc func fhh_reConfigNavMiddleButton() {
        fhh_navMiddleButton?.sizeToFit()
        var maxWidth = (fhh_navigationBar?.fhh_width)! - 30
        if fhh_navLeftButton != nil && fhh_navRightButton != nil {
            maxWidth = (fhh_navRightButton?.fhh_x)! - (fhh_navLeftButton?.fhh_right)! - 30
        } else if fhh_navLeftButton != nil {
            maxWidth = (fhh_navigationBar?.fhh_width)! - (fhh_navLeftButton?.fhh_right)!
        }
        if (fhh_navMiddleButton?.fhh_width)! > maxWidth {
            fhh_navMiddleButton?.fhh_width = maxWidth
        }
        if UIDevice.fhh_isiPhoneX() {
            fhh_navMiddleButton?.center = CGPoint.init(x: (fhh_navigationBar?.fhh_centerX)!, y:(fhh_navLeftButton?.fhh_centerY)! + 12.5)
        } else {
            fhh_navMiddleButton?.center = CGPoint.init(x: (fhh_navigationBar?.fhh_centerX)!, y:(fhh_navLeftButton?.fhh_centerY)! + 10)
        }
    }
    
    private func fhh_configBottomSepImageView() {
        let frame = CGRect.init(x: 0, y: (fhh_navigationBar?.fhh_height)! - 0.5, width: (fhh_navigationBar?.fhh_width)!, height: 0.5)
        let bottomSepImageView = UIImageView.init(frame: frame)
        bottomSepImageView.backgroundColor = UIColor.init(red: 220 / 255.0, green: 220 / 255.0, blue: 220 / 255.0, alpha: 1.0)
    }
    
    // MARK:HandleEvents
    @objc func fhh_clickLeftNavButton() {
        if self.fhh_enterType == .push {
            self.navigationController?.popViewController(animated: true)
        } else if self.navigationController != nil {
            self.navigationController?.dismiss(animated: true, completion: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func fhh_removeNavLeftButtonDefaultEvent() {
        fhh_navLeftButton?.removeTarget(self, action: #selector(fhh_clickLeftNavButton), for: .touchUpInside)
    }
    
    // MARK:Properties
    var fhh_navigationBar: UIView? {
        get {
            return (objc_getAssociatedObject(self, &kNavigationBarKey) as? UIView)
        }
        set(newValue) {
            objc_setAssociatedObject(self, &kNavigationBarKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var fhh_navMiddleButton: UIButton? {
        get {
            return (objc_getAssociatedObject(self, &kNavMiddleButtonKey) as? UIButton)
        }
        set(newValue) {
            objc_setAssociatedObject(self, &kNavMiddleButtonKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var fhh_navLeftButton: UIButton? {
        get {
            return (objc_getAssociatedObject(self, &kNavLeftButtonKey) as? UIButton)
        }
        set(newValue) {
            objc_setAssociatedObject(self, &kNavLeftButtonKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var fhh_navRightButton: UIButton? {
        get {
            return (objc_getAssociatedObject(self, &kNavRightButtonKey) as? UIButton)
        }
        set(newValue) {
            objc_setAssociatedObject(self, &kNavRightButtonKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var fhh_enterType: FHHEnterType {
        get {
            let enterTypeRawValue = objc_getAssociatedObject(self, &kEnterType)
            if enterTypeRawValue != nil {
                return FHHEnterType.init(rawValue: enterTypeRawValue as! NSInteger)!
            }
            return .push
        }
        // set this value after you call functions fhh_setNavigationBar...
        set(newValue) {
            objc_setAssociatedObject(self, &kEnterType, newValue.rawValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
}
