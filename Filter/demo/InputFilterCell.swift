//
//  InputFilterCell.swift
//  Filter
//
//  Created by 孟冰川 on 2018/3/29.
//  Copyright © 2018年 com.36kr. All rights reserved.
//

import UIKit

class InputFilterCell: RangeFilterBaseCell {
    
    let input = UITextField()
    
    override var condition: FilterCondition? {
        didSet {
            if let c = condition as? InputFilterCondition {
                if let desc = c.input?.desc {
                    input.text = desc
                }else {
                    input.text = nil
                    input.placeholder = c.placeHolder
                }
            }
        }
    }
    
    override func commonInit() {
        super.commonInit()
        addSubview(input)
        input.addTarget(self, action: #selector(textInputDidChange), for: .editingChanged)
        input.layer.borderWidth = 1
        input.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        input.frame.origin = CGPoint(x: frame.width/4, y: frame.height/2 - input.frame.height/2)
        input.frame.size = CGSize(width: frame.width/2, height: 25)
    }

    @objc func textInputDidChange() {
        if let c = condition as? InputFilterCondition {
            if let i = c.input as? TextInputItem {
                i.input = input.text
            }
        }
    }
}
