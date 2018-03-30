//
//  ConditionItemImp.swift
//  Filter
//
//  Created by 孟冰川 on 2018/3/30.
//  Copyright © 2018年 com.36kr. All rights reserved.
//

import Foundation

class DefaultConditionItem: ConiditionItem {
    
    var condition: String?
    
    var value: Any? {
        return condition
    }
    
    var desc: String?
    var choose = false
    func copy() -> ConiditionItem {
        let c = DefaultConditionItem()
        c.choose = choose
        c.condition = condition
        c.desc = desc
        return c
    }
}

class TextInputItem: InputItem {
    
    var value: Any? {
        return input
    }
    var input: String? {
        didSet {
            desc = input
        }
    }
    var placeHolder: String?
    var desc: String?
    
}
