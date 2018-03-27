//
//  FilterViewController.swift
//  Filter
//
//  Created by 孟冰川 on 2018/3/26.
//  Copyright © 2018年 com.36kr. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    var confirmBlock: (([String: Any?]) -> Void)?
    var conditions: [FilterCondition]!
    var collectionView: UICollectionView?
    
    var configuration: FilterConfiguration!
    
    @objc func reset() {
        conditions.forEach({$0.reset()})
        collectionView?.reloadData()
    }
    
    @objc func confirm(){
        let initDic = [String: Any?]()
        let dic: [String: Any?] = conditions.flatMap({$0.condition}).reduce(initDic) { (result, item) -> [String: Any?] in
            return result.merging(item, uniquingKeysWith: { (current, _) in current })
        }
        //交给具体实现去做检查和处理
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
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return conditions[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        conditions[indexPath.section].setIndex(index: indexPath)
        collectionView.reloadData()
    }
}
