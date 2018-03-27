//
//  Utils.swift
//  Filter
//
//  Created by 孟冰川 on 2018/3/26.
//  Copyright © 2018年 com.36kr. All rights reserved.
//

import UIKit


struct SizeConst {
    
    static let onePixel: CGFloat = 1/UIScreen.main.scale
    
}

extension UIColor {
 
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        let r = CGFloat(((hex & 0xFF0000) >> 16)) / 255.0
        let g = CGFloat(((hex & 0xFF00) >> 8)) / 255.0
        let b = CGFloat(((hex & 0xFF))) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}

private var pTouchAreaEdgeInsets: UIEdgeInsets = UIEdgeInsets.zero
extension UIButton {
    
    func swapTextAndImageWith(spacing: CGFloat) {
        guard let image = currentImage,let label = titleLabel else { return }
        label.sizeToFit()
        let insetAmount = spacing / 2
        let labelWidth = label.frame.width
        let imageWidth = image.size.width
        imageEdgeInsets = UIEdgeInsets(top: 0, left: (labelWidth + insetAmount), bottom: 0, right: -(labelWidth + insetAmount))
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imageWidth + insetAmount), bottom: 0, right: (imageWidth + insetAmount))
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
    
    var touchAreaEdgeInsets: UIEdgeInsets {
        get {
            if let value = objc_getAssociatedObject(self, &pTouchAreaEdgeInsets) as? NSValue {
                var edgeInsets = UIEdgeInsets.zero
                value.getValue(&edgeInsets)
                return edgeInsets
            }
            else {
                return UIEdgeInsets.zero
            }
        }
        set(newValue) {
            var newValueCopy = newValue
            let objCType = NSValue(uiEdgeInsets: UIEdgeInsets.zero).objCType
            let value = NSValue(&newValueCopy, withObjCType: objCType)
            objc_setAssociatedObject(self, &pTouchAreaEdgeInsets, value, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}

extension UITableViewCell {
    
    static var cellIdentifier: String {
        return String(describing: self)
    }
    
}

extension UICollectionReusableView {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
