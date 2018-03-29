//
//  SelectFilterCell.swift
//  Filter
//
//  Created by 孟冰川 on 2018/3/27.
//  Copyright © 2018年 com.36kr. All rights reserved.
//

import UIKit

class SelectFilterItemViewCell: SelectFilterBaseCell {
    
    var titleLabel = UILabel()        
    
    override var item: ConiditionItem? {
        didSet {
            guard let i = item else { return }
            if i.choose {
                titleLabel.textColor = UIColor(hex: 0x8073e2)
                layer.borderColor = UIColor(hex: 0x8073e2).withAlphaComponent(0.12).cgColor
            }else {
                titleLabel.textColor = UIColor(hex: 0x333333)
                layer.borderColor = UIColor(hex: 0xf4f4f4).cgColor
            }
            titleLabel.text = i.desc
        }
    }
    
    override func commonInit() {
        super.commonInit()
        addSubview(titleLabel)
        titleLabel.textAlignment = .center
        layer.borderWidth = 1
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.sizeToFit()
        titleLabel.frame = bounds
    }
    
}
