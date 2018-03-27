//
//  FilterCondition.swift
//  Filter
//
//  Created by 孟冰川 on 2018/3/26.
//  Copyright © 2018年 com.36kr. All rights reserved.
//

import Foundation

protocol ConiditionItem: class {
    var desc: String? { get set }
    var choose: Bool { get set }
    func copy() -> ConiditionItem
}

enum ListFilterSectionType {
    case singleChoice
    case multipleChoice
    case range
}

class SelectFilterCondition: FilterCondition{
    
    var items: [ConiditionItem]?
    //考虑到有些单选里有个全部的选项，默认是选中状态，这里需要兼容
    var origin: [ConiditionItem]? {
        didSet {
            items = origin?.map({$0.copy()})
        }
    }
    
    var configuration: FilterConfiguration!
    
    var required = false
    
    override var needShowPackUp: Bool {
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
    
    override func setIndex(index: IndexPath) {
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
        case .range:
            ()
        }
    }
}

class RangeFilterCondition<T>: FilterCondition{
    
    var min: T?
    var max: T?
    //默认设置placeHolder
    var minDesc: String?
    var maxDesc: String?
    
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

class FilterCondition {
    
    var title: String?
    var cellIdentifier: String!
    var type: ListFilterSectionType!
    
    var count: Int{
        return 0
    }
    
    var needShowPackUp: Bool {
        return false
    }
    
    var isPackUp = true
    
    var condition: [String: Any?]? {
        return [:]
    }
    
    func reset(){
        
    }
    
    func setIndex(index: IndexPath) {
        
    }
}
