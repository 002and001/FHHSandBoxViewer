//
//  UIView+FHHFrmae.swift
//  USchool
//
//  Created by hefanghui on 2017/9/14.
//  Copyright © 2017年 topglobaledu. All rights reserved.
//
//  Main function:UIView计算frame的分类
//
//  Other specifications:
//
//  ************************************************************************

import UIKit

extension UIView {
    
    // MARK: Properties
    public var fhh_x: CGFloat {
        set {
            var frame = self.frame;
            frame.origin.x = newValue;
            self.frame = frame;
        }
        get {
            return self.frame.origin.x;
        }
    }
    
    public var fhh_y: CGFloat {
        set {
            var frame = self.frame;
            frame.origin.y = newValue;
            self.frame = frame;
        }
        get {
            return self.frame.origin.y;
        }
    }
    
    public var fhh_width: CGFloat {
        set {
            var frame = self.frame;
            frame.size.width = newValue;
            self.frame = frame;
        }
        get {
            return self.frame.size.width;
        }
    }
    
    public var fhh_height: CGFloat {
        set {
            var frame = self.frame;
            frame.size.height = newValue;
            self.frame = frame;
        }
        get {
            return self.frame.size.height;
        }
    }
    
    public var fhh_right: CGFloat {
        set {
            var frame = self.frame;
            frame.origin.x = (newValue - self.frame.size.width);
            self.frame = frame;
        }
        get {
            return (self.frame.origin.x + self.frame.size.width);
        }
    }
    
    public var fhh_bottom: CGFloat {
        set {
            var frame = self.frame;
            frame.origin.y = (newValue - self.frame.size.height);
            self.frame = frame;
        }
        get {
            return (self.frame.origin.y + self.frame.size.height);
        }
    }
    
    public var fhh_centerX: CGFloat {
        set {
            var center = self.center;
            center.x = newValue;
            self.center = center;
        }
        get {
            return self.center.x;
        }
    }
    
    public var fhh_centerY: CGFloat {
        set {
            var center = self.center;
            center.y = newValue;
            self.center = center;
        }
        get {
            return self.center.y;
        }
    }
    
    public var fhh_origin: CGPoint {
        set {
            self.frame.origin = newValue;
        }
        get {
            return self.frame.origin;
        }
    }
    
    public var fhh_size: CGSize {
        set {
            self.frame.size = newValue;
        }
        get {
            return self.frame.size;
        }
    }
    
    // MARK: Functions
    public func fhh_frameInView(view: UIView) -> CGRect {
        let frame = self.convert(self.bounds, to: view)
        return frame
    }
    
    public func fhh_xInView(view: UIView) -> CGFloat {
        let frame = self.convert(self.bounds, to: view)
        return frame.origin.x;
    }
    
    public func fhh_yInView(view: UIView) -> CGFloat {
        let frame = self.convert(self.bounds, to: view)
        return frame.origin.y;
    }
    
    public func fhh_rightInView(view: UIView) -> CGFloat {
        let frame = self.convert(self.bounds, to: view)
        return (frame.origin.x + frame.size.width)
    }
    
    public func fhh_bottomInView(view: UIView) -> CGFloat {
        let frame = self.convert(self.bounds, to: view)
        return (frame.origin.y + frame.size.height)
    }
    
    public func fhh_centerXInView(view: UIView) -> CGFloat {
        let frame = self.convert(self.bounds, to: view)
        return (frame.origin.x + frame.size.width * 0.5)
    }
    
    public func fhh_centerYInView(view: UIView) -> CGFloat {
        let frame = self.convert(self.bounds, to: view)
        return (frame.origin.y + frame.size.height * 0.5)
    }
}
