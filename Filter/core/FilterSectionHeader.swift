//
//  FilterSectionHeader.swift
//  Filter
//
//  Created by 孟冰川 on 2018/3/30.
//  Copyright © 2018年 com.36kr. All rights reserved.
//

import UIKit


class FilterSectionHeader: UICollectionReusableView {
    
    var tapBlock: (() -> Void)?
    
    var condition: FilterCondition? {
        didSet {
            if let c = condition {
                if let c = c as? SelectFilterCondition {
                    hideFoldEntry = !c.needShowPackUp
                    arrowDown = c.isPackUp
                }else {
                    hideFoldEntry = true
                }
            }
        }
    }
    
    //在didSet中设置是否隐藏header中尾部的折叠入口
    var hideFoldEntry = true
    
    //在didSet中设置箭头和文字
    var arrowDown = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    }
    
    @objc func tap() {
        guard let c = condition as? SelectFilterCondition else { return }
        if c.needShowPackUp {
            c.isPackUp = !c.isPackUp
            tapBlock?()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
