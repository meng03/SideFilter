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
    
    fileprivate var bgImageView: UIImageView = UIImageView()
    
    override var item: ConiditionItem? {
        didSet {
            guard let i = item else { return }
            if i.choose {
                titleLabel.textColor = UIColor(hex: 0x8073e2)
                setBgColor(UIColor(hex: 0x8073e2).withAlphaComponent(0.12))
            }else {
                titleLabel.textColor = UIColor(hex: 0x333333)
                setBgColor(UIColor(hex: 0xf4f4f4))
            }
            titleLabel.text = i.desc
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.sizeToFit()
        titleLabel.frame = bounds
    }
    
    fileprivate func setBgColor(_ color: UIColor) {
//        bgImageView.removeFromSuperview()
//        bgImageView = UIImageView(image: kt_drawRectWithRoundedCorner(radius: 4,
//                                                                      borderWidth: 0,
//                                                                      backgroundColor: color,
//                                                                      borderColor: UIColor.clear))
//        self.insertSubview(bgImageView, at: 0)
        layer.borderColor = color.cgColor
        layer.borderWidth = 1
    }
    
}
