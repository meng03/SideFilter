//
//  InputFilterCell.swift
//  Filter
//
//  Created by 孟冰川 on 2018/3/29.
//  Copyright © 2018年 com.36kr. All rights reserved.
//

import UIKit

class TextInputFilterCell: RangeFilterBaseCell {
    
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

class ValueRangeInputFilterCell: RangeFilterBaseCell {
    
    let minInput = UITextField()
    let maxInput = UITextField()
    
    override var condition: FilterCondition? {
        didSet {
            if let c = condition as? RangeFilterCondition {
                if let desc = c.min?.desc {
                    minInput.text = desc
                }else {
                    minInput.text = nil
                    minInput.placeholder = c.min?.placeHolder
                }
                if let desc = c.max?.desc {
                    maxInput.text = desc
                }else {
                    maxInput.text = nil
                    maxInput.placeholder = c.max?.placeHolder
                }
            }
        }
    }
    
    override func commonInit() {
        super.commonInit()
        addSubview(minInput)
        minInput.addTarget(self, action: #selector(textInputMinDidChange), for: .editingChanged)
        minInput.layer.borderWidth = 1
        minInput.layer.borderColor = UIColor.lightGray.cgColor
        addSubview(maxInput)
        maxInput.addTarget(self, action: #selector(textInputMaxDidChange), for: .editingChanged)
        maxInput.layer.borderWidth = 1
        maxInput.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        minInput.frame.size = CGSize(width: frame.width/4, height: 25)
        minInput.frame.origin = CGPoint(x: frame.width/6, y: frame.height/2 - minInput.frame.height/2)
        maxInput.frame.size = CGSize(width: frame.width/4, height: 25)
        maxInput.frame.origin = CGPoint(x: frame.width*7/12, y: frame.height/2 - minInput.frame.height/2)
        
    }

    @objc func textInputMinDidChange() {
        if let c = condition as? RangeFilterCondition {
            if let i = c.min as? TextInputItem {
                i.input = minInput.text
            }
        }
    }
    
    @objc func textInputMaxDidChange() {
        if let c = condition as? RangeFilterCondition {
            if let i = c.max as? TextInputItem {
                i.input = maxInput.text
            }
        }
    }
}
