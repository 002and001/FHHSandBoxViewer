//
//  ViewController.swift
//  Demo-Swift
//
//  Created by hefanghui on 2018/4/28.
//  Copyright © 2018年 hefanghui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var enterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        enterButton.addTarget(self, action: #selector(viewSandBox), for: .touchUpInside)
    }
    
    @objc private func viewSandBox() {
        let title = FHHSandboxViewController.defaultNavTitle
        let path = FHHSandboxViewController.defaultPath
        let sandBoxViewerVC = FHHSandboxViewController.init(navTitle: title, path: path)
        let nav = UINavigationController.init(rootViewController: sandBoxViewerVC)
        nav.navigationBar.isHidden = true
        nav.navigationBar.isTranslucent = true
        self.present(nav, animated: true, completion: nil)
        sandBoxViewerVC.fhh_enterType = .present
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

