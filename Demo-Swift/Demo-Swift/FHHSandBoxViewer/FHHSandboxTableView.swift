//
//  FHHSandboxTableView.swift
//  StudentLive
//
//  Created by hefanghui on 2018/4/25.
//  Copyright © 2018年 hqyxedu. All rights reserved.
//

import UIKit

@objc class FHHSandboxTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    var sandboxViewModelArray: [FHHSandboxViewModel] = [FHHSandboxViewModel]()

    // MARK:Init
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.configOwnProperties()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        FHHLog("deinit")
    }
    
    // MARK:Functions
    private func configOwnProperties() {
        self.register(FHHSandboxTableViewCell.self, forCellReuseIdentifier: FHHSandboxTableViewCell.kIdentify)
        self.dataSource = self
        self.delegate = self
    }
    
    // MARK:HandleViews
    func refresh(viewModelArray: [FHHSandboxViewModel]) {
        self.sandboxViewModelArray = viewModelArray
        self.reloadData()
    }
    
    // MARK:UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sandboxViewModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = sandboxViewModelArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FHHSandboxTableViewCell.kIdentify, for: indexPath) as! FHHSandboxTableViewCell
        cell.refresh(viewModel: viewModel)
        return cell
    }
    
    // MARK:UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = sandboxViewModelArray[indexPath.row]
        if viewModel.didSelectBlock != nil {
            viewModel.didSelectBlock!()
        }        
    }
        
}
