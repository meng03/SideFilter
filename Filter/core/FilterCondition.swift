//
//  FilterCondition.swift
//  Filter
//
//  Created by 孟冰川 on 2018/3/26.
//  Copyright © 2018年 com.36kr. All rights reserved.
//

import Foundation

enum ListFilterSectionType {
    case singleChoice
    case multipleChoice
    case range
    case input
}

protocol ConiditionItem: class {
    var desc: String? { get set }
    var choose: Bool { get set }
    var value: Any? { get }
    func copy() -> ConiditionItem
}

//输入类型（输入文字，时间选择）
protocol InputItem: class {
    var placeHolder: String? { get set }
    var value: Any? { get }
}

class SelectFilterCondition: FilterCondition{
    
    var items: [ConiditionItem]?
    //考虑到有些单选里有个全部的选项，默认是选中状态，这里需要兼容
    var origin: [ConiditionItem]? {
        didSet {
            items = origin?.map({$0.copy()})
        }
    }
    
    var isPackUp = true
    
    var configuration: FilterConfiguration!
    
    var required = false
    
    var needShowPackUp: Bool {
        return (items?.count ?? 0) > configuration.packUpCount
    }
    
    override var count: Int {
        if isPackUp {
            return min(items?.count ?? 0,configuration.packUpCount)
        }else {
            return items?.count ?? 0
        }
    }
    
    override func reset() {
        items = origin?.map({$0.copy()})
    }
    
    func setIndex(index: IndexPath) {
        switch type! {
        case .multipleChoice:
            if let choose = items?[index.row].choose {
                items?[index.row].choose = !choose
            }
        case .singleChoice:
            if let choose = items?[index.row].choose {
                items?.forEach({ (item) in
                    item.choose = false
                })
                if required {
                    items?[index.row].choose = true
                }else {
                    items?[index.row].choose = !choose
                }
                
            }
        case .range,.input:
            ()
        }
    }
}

class RangeFilterCondition: FilterCondition{
    
    var min: InputItem?
    var max: InputItem?
    
    override var count: Int {
        return 1
    }
    
    override init() {
        super.init()
        type = .range
    }
    
    override func reset() {
        min = nil
        max = nil
    }
}

class inputFilterCondition: FilterCondition {
    var input: InputItem?
    var placeHolder: String?
    
    override var count: Int {
        return 1
    }
    
    override init() {
        super.init()
        type = .input
    }
    
    override func reset() {
        input = nil
    }
}

class FilterCondition {
    
    var title: String?
    var cellIdentifier: String!
    var type: ListFilterSectionType!
    var key: String!
    
    var count: Int{
        return 0
    }
    
    var condition: [String: Any?]? {
        return [:]
    }
    
    func reset(){
        
    }
}
