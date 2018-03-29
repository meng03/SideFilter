//
//  FilterViewController.swift
//  Filter
//
//  Created by 孟冰川 on 2018/3/26.
//  Copyright © 2018年 com.36kr. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    var confirmBlock: (([String: Any]) -> Void)?
    var conditions: [FilterCondition]!
    var collectionView: UICollectionView?
    
    var configuration: FilterConfiguration!
    
    @objc func reset() {
        conditions.forEach({$0.reset()})
        collectionView?.reloadData()
    }
    
    @objc func confirm(){
        var dic = [String: Any]()
        for c in conditions {
            switch c.type! {
            case .singleChoice:
                let selectedItem = (c as? SelectFilterCondition)?.items?.filter({$0.choose}).first
                if let value = selectedItem?.value {
                    dic.merge([c.key: value], uniquingKeysWith: {(current,_) in current})
                }
            case .multipleChoice:
                if let selectedItems = (c as? SelectFilterCondition)?.items?.filter({$0.choose}),selectedItems.count > 0 {
                    var values = [Any]()
                    for item in selectedItems {
                        if let value = item.value {
                            values.append(value)
                        }
                    }
                    dic.merge([c.key: values], uniquingKeysWith: {(current,_) in current})
                }
            case .input:
                if let value = (c as? inputFilterCondition)?.input?.value {
                    dic.merge([c.key: value], uniquingKeysWith: {(current,_) in current})
                }
            case .range:
                let range = c as? RangeFilterCondition
                var rangeDic = [String: Any]()
                if let min = range?.min?.value {
                    rangeDic.merge(["min": min], uniquingKeysWith: {(current,_) in current})
                }
                if let max = range?.max?.value {
                    rangeDic.merge(["max": max], uniquingKeysWith: {(current,_) in current})
                }
                if rangeDic.count > 0 {
                    dic.merge([c.key: rangeDic], uniquingKeysWith: {(current,_) in current})
                }
            }
        }
        confirmBlock?(dic)
    }    
}

extension FilterViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return conditions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let condition = conditions[indexPath.section]
        switch condition.type! {
        case .multipleChoice,.singleChoice:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: condition.cellIdentifier, for: indexPath) as! SelectFilterBaseCell
            cell.item = (condition as? SelectFilterCondition)?.items?[indexPath.row]
            return cell
        case .range:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: condition.cellIdentifier, for: indexPath) as! RangeFilterBaseCell
            cell.condition = condition
            return cell
        case .input:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: condition.cellIdentifier, for: indexPath) as! RangeFilterBaseCell
            cell.condition = condition
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return conditions[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let con = conditions[indexPath.section] as? SelectFilterCondition {
            con.setIndex(index: indexPath)
            collectionView.reloadData()
        }
    }
}
