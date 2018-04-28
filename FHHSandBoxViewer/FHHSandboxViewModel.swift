//
//  FHHSandboxViewModel.swift
//  StudentLive
//
//  Created by hefanghui on 2018/4/25.
//  Copyright © 2018年 hqyxedu. All rights reserved.
//

import UIKit

@objc class FHHSandboxViewModel: NSObject {
    
    var pathURL: URL?
    var pathLastName: String?
    var isDir = false
    var didSelectBlock: (() -> Void)?
    var isSelected: Bool = false
    
    deinit {
        FHHLog("deinit")
    }
}
