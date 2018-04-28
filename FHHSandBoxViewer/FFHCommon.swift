//
//  FFHCommon.swift
//  FHHSandBoxManager
//
//  Created by hefanghui on 2018/4/27.
//  Copyright © 2018年 hefanghui. All rights reserved.
//

import UIKit

func FHHLog<T>(_ message: T, file: String = #file, function: String = #function, lineNumber: Int = #line) {
    #if DEBUG
    let date = NSDate()
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "yyy-MM-dd  HH:mm:ss.SSS"
    let strNowTime = timeFormatter.string(from: date as Date) as String
    let fileName = (file as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")
    print("\(strNowTime) - [\(fileName) \(function)] [line \(lineNumber)]- \(message)")
    #endif
}

func fhh_rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
    let color = UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    return color
}

func isSimulator() -> Bool {
    var isSim = false
    #if arch(i386) || arch(x86_64)
    isSim = true
    #endif
    return isSim
}  

