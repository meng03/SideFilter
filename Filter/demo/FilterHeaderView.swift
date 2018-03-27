//
//  FilterHeaderView.swift
//  Filter
//
//  Created by 孟冰川 on 2018/3/26.
//  Copyright © 2018年 com.36kr. All rights reserved.
//

import UIKit

class ListFilterHeaderView: UICollectionReusableView {
    
    var tapBlock: (() -> Void)?
    
    var label = UILabel()
    var indicatorBtn = UIButton()
    var topDividerView = UIView()
    
    var condition: FilterCondition? {
        didSet {
            if let c = condition {
                indicatorBtn.isHidden = !c.needShowPackUp
                arrowDown = c.isPackUp
                label.text = c.title
                label.sizeToFit()
            }
        }
    }
    
    var arrowDown: Bool = true {
        didSet {
            if arrowDown {
                indicatorBtn.setTitle("更多", for: .normal)
                indicatorBtn.setImage(UIImage(named: "filter_icon_arrowdown"), for: .normal)
            } else {
                indicatorBtn.setTitle("收起", for: .normal)
                indicatorBtn.setImage(UIImage(named: "filter_icon_arrowup"), for: .normal)
            }
            indicatorBtn.swapTextAndImageWith(spacing: 5)
        }
    }
    
    override init(frame: CGRect) {
        label.textColor = UIColor(hex: 0x999999)
        label.font = UIFont.systemFont(ofSize: 13)
        label.backgroundColor = UIColor.clear
        
        indicatorBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        indicatorBtn.setTitleColor(UIColor(hex: 0x999999), for: .normal)
        indicatorBtn.touchAreaEdgeInsets = UIEdgeInsetsMake(-10, -10, -10, -10)
        topDividerView.backgroundColor = UIColor(hex: 0xeaeaea)
        
        super.init(frame: frame)
        
        indicatorBtn.addTarget(self, action: #selector(tap), for: .touchUpInside)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        
        addSubview(label)
        addSubview(indicatorBtn)
        addSubview(topDividerView)
    }
    
    @objc func tap() {
        guard let c = condition else { return }
        if c.needShowPackUp {
            c.isPackUp = !c.isPackUp
            tapBlock?()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let height = frame.height
        let width = frame.width
        
        label.sizeToFit()
        label.frame.origin = CGPoint(x: 15, y: height/2 - label.frame.height/2)
        label.center.y = height/2
        
        indicatorBtn.frame.size = (CGSize(width: 44, height: 27))
        indicatorBtn.frame.origin = CGPoint(x: width - 44 - 15, y: height/2 - indicatorBtn.frame.height/2)
        
        topDividerView.frame.origin = CGPoint(x: 0, y: 0)
        topDividerView.frame.size = CGSize(width: width, height: SizeConst.onePixel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


