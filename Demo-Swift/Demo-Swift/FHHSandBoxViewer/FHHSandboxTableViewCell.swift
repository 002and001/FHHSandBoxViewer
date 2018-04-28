//
//  FHHSandboxTableViewCell.swift
//  StudentLive
//
//  Created by hefanghui on 2018/4/25.
//  Copyright © 2018年 hqyxedu. All rights reserved.
//

import UIKit

@objc class FHHSandboxTableViewCell: UITableViewCell {
    
    // MARK:Properties
    var viewModel: FHHSandboxViewModel?
    class var kIdentify: String {
        return "kSandboxTableViewCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    deinit {
        FHHLog("deinit")
    }
    
    // MARK:HandleViews
    func refresh(viewModel: FHHSandboxViewModel) {
        self.viewModel = viewModel
        self.configselectBoxView()
        self.configNameLabel()
    }
    
    func configNameLabel() {
        self.contentView.addSubview(nameLabel)
        
        nameLabel.text = viewModel?.pathLastName
        nameLabel.sizeToFit()
        nameLabel.fhh_width = UIDevice.fhh_kScreenW() - 50
        nameLabel.fhh_x = 10
        nameLabel.fhh_centerY = self.fhh_height * 0.5
    }
    
    func configselectBoxView() {
        self.contentView.addSubview(selectBoxView)
        
        selectBoxView.fhh_right = self.fhh_width - 10
        selectBoxView.fhh_centerY = self.fhh_height * 0.5
        if (viewModel?.isSelected)! == false {
            selectBoxView.refresh2NormalState()
        } else {
            selectBoxView.refresh2SelectedState()
        }
    }

    // MARK:Properties
    private lazy var selectBoxView: FHHSelectBoxView = {
        let frame = CGRect.init(x: 0, y: 0, width: 20, height: 20)
        let view = FHHSelectBoxView.init(frame: frame)
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()

}

class FHHSelectBoxView: UIView {
    
    // MARK:Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = self.frame.size.width * 0.5
        self.layer.masksToBounds = true
        self.refresh2SelectedState()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:HandleViews
    func refresh(isSelect: Bool) {
        if isSelect {
            self.refresh2SelectedState()
        } else {
            self.refresh2NormalState()
        }
    }
    
    func refresh2NormalState() {
        self.isHidden = true
    }
    
    func refresh2SelectedState() {
        self.isHidden = false
        self.layer.borderColor = UIColor.white.cgColor
        self.backgroundColor = UIColor.orange
    }
}
