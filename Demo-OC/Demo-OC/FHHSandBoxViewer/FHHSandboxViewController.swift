//
//  FHHSandboxViewController.swift
//  StudentLive
//
//  Created by hefanghui on 2018/4/25.
//  Copyright © 2018年 hqyxedu. All rights reserved.
//

import UIKit

@objc class FHHSandboxViewController: UIViewController, FHHSandboxAccessoryViewDelegate {
    
    // MARK:Properties
    var path: String
    var navTitle: String
    var isSelected: Bool = false
    var viewModelArray = [FHHSandboxViewModel]()
    let fileManager = FileManager.default
    
    @objc class var defaultNavTitle: String {
        return "Sandbox"
    }
    
    @objc class var defaultPath: String {
        var path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        path = path.replacingOccurrences(of: "/Library", with: "")
        if isSimulator() {
            path = path.replacingOccurrences(of: "/Developer/CoreSimulator/", with: "/Library/Developer/CoreSimulator/")
        }
        return path
    }
    
    // MARK:Init
    @objc init(navTitle: String, path: String) {
        self.navTitle = navTitle
        self.path = path
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.initNavigationBar()
        self.configSubViews()
        FHHLog("path:\(path)")
        self.recursive(path: path)
    }
    
    deinit {
        FHHLog("deinit")
    }
    
    // MARK:SandboxAccessoryViewDelegate
    func SandboxAccessory(_: FHHSandboxAccessoryView, didClickSharedButton: UIButton) {
        let shareURLArray = self.getSelectedURL()
        let vc = UIActivityViewController.init(activityItems: shareURLArray, applicationActivities: nil)
        let completionWithItemsHandler = { (type: UIActivityType?, isSucceed: Bool?,array: Array<Any>?, error: Error?)  in
            FHHLog("error:\(String(describing: error?.localizedDescription))")
            self.resetToUnSelectState()
            self.tableView.refresh(viewModelArray: self.viewModelArray)
        }
        vc.completionWithItemsHandler = completionWithItemsHandler
        self.present(vc, animated: true, completion:nil)
    }
    
    // MARK:Functions
    private func initNavigationBar() {
        self.fhh_setNavigationBar(title: navTitle, navLeftButtonIcon: "", navRightButtonTitle: "selcet")
        self.fhh_navRightButton?.addTarget(self, action: #selector(navRightButtonDidClick), for: .touchUpInside)
    }
    
    private func recursive(path: String) {
        var isDir = ObjCBool(false)
        let isExist = fileManager.fileExists(atPath: path, isDirectory: &isDir)
        if isExist {
            if isDir.boolValue == true {
                do {
                    let dirArray = try fileManager.contentsOfDirectory(atPath: path)
                    for dirName in dirArray {
                        let viewModel = self.getViewModel(path: path, dirName: dirName)
                        viewModelArray.append(viewModel)
                    }
                    tableView.refresh(viewModelArray: viewModelArray)
                } catch {
                    FHHLog("error\(error)")
                }
            } else {
                FHHLog("path:\(path) contains nothing)")
            }
        }
    }
    
    private func getSelectedURL() -> [URL] {
        var urlArray = [URL]()
        for viewModel in viewModelArray {
            if viewModel.isSelected {
                urlArray.append(viewModel.pathURL!)
            }
        }
        return urlArray
    }
    
    private func getViewModel(path: String, dirName: String) -> FHHSandboxViewModel {
        let viewModel = FHHSandboxViewModel.init()
        
        let subPath = path.appending("/\(dirName)")
        var isSubDir = ObjCBool(false)
        fileManager.fileExists(atPath: subPath, isDirectory: &isSubDir)
        let lastName = self.getSubPathLastName(subPath: subPath, path: path, isSubDir: isSubDir.boolValue)
        viewModel.pathLastName = lastName
        viewModel.pathURL = URL.init(fileURLWithPath: subPath)
        viewModel.isDir = isSubDir.boolValue
        self.configSandboxViewModelDidSelectBlock(viewModel: viewModel, subPath: subPath)
        return viewModel
    }
    
    private func configSandboxViewModelDidSelectBlock(viewModel: FHHSandboxViewModel, subPath: String) {
        viewModel.didSelectBlock = { [weak self, weak viewModel] in
            if (self?.isSelected)! {
                viewModel?.isSelected = !(viewModel?.isSelected)!
                self?.tableView.reloadData()
                self?.refreshAccessoryView()
            } else {
                if (viewModel?.isDir)! {
                    let vc = FHHSandboxViewController.init(navTitle: (viewModel?.pathLastName!)!, path: subPath)
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    private func getSubPathLastName(subPath: String, path: String, isSubDir: Bool) -> String {
        if isSubDir {
            return (subPath as NSString).replacingOccurrences(of: "\(path)/", with: "/")
        }
        return (subPath as NSString).replacingOccurrences(of: "\(path)/", with: "")
    }
    
    // MARK:HandleEvents
    @objc func returnToLastVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func navRightButtonDidClick() {
        isSelected = !isSelected
        if isSelected {
            self.fhh_navRightButton?.setTitle("cancel", for: .normal)
        } else {
            self.resetToUnSelectState()
        }
        self.tableView.reloadData()
    }
    
    // MARK:HandleViews
    private func configSubViews() {
        self.view.addSubview(tableView)
        
        self.view.addSubview(accessoryView)
        accessoryView.fhh_x = 0
        accessoryView.fhh_y = tableView.fhh_bottom
    }
    
    private func resetToUnSelectState() {
        self.isSelected = false
        self.fhh_navRightButton?.setTitle("select", for: .normal)
        self.reSetViewModelAllSelectState()
        self.tableView.refresh(viewModelArray: viewModelArray)
        self.accessoryView.refreshShareButton(enable: false)
    }
    
    func refreshAccessoryView() {
        for viewModel in viewModelArray {
            if viewModel.isSelected {
                self.accessoryView.refreshShareButton(enable: true)
                return
            }
        }
        self.accessoryView.refreshShareButton(enable: false)
    }
    
    private func reSetViewModelAllSelectState() {
        for viewModel in viewModelArray {
            viewModel.isSelected = false
        }
    }
    
    // MARK:LazyLoads
    private lazy var tableView: FHHSandboxTableView = {
        let frame = CGRect.init(x: 0, y: UIDevice.fhh_kNavigationBarHeight(), width: UIDevice.fhh_kScreenW(), height: UIDevice.fhh_kScreenH() - UIDevice.fhh_kNavigationBarHeight() - self.accessoryView.fhh_height)
        let tableView = FHHSandboxTableView.init(frame: frame, style: UITableViewStyle.grouped)
        return tableView
    }()
    
    private lazy var accessoryView: FHHSandboxAccessoryView = {
        let frame = CGRect.init(x: 0, y: 0, width: UIDevice.fhh_kScreenW(), height: 50)
        let view = FHHSandboxAccessoryView.init(frame: frame)
        view.refreshShareButton(enable: false)
        view.delegate = self
        return view
    }()
    
}
