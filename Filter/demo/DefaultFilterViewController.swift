//
//  DefaultFilterViewController.swift
//  Filter
//
//  Created by 孟冰川 on 2018/3/26.
//  Copyright © 2018年 com.36kr. All rights reserved.
//

import UIKit

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

class DefaultFilterViewController: FilterViewController {
    
    let confirmButton = UIButton()
    let resetButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configData()
        configSubView()
        confirmBlock = {(dic) in
            print(dic)
        }
    }
    
    func configData() {
        configuration = FilterConfiguration()
        let condition1 = SelectFilterCondition()
        condition1.title = "条件1"
        condition1.configuration = configuration
        condition1.type = .singleChoice
        condition1.key = "条件1"
        condition1.cellIdentifier = SelectFilterItemViewCell.identifier
        condition1.required = true
        var c1Items = [DefaultConditionItem]()
        for i in 0...3 {
            let item = DefaultConditionItem()
            item.condition = "c\(i)"
            item.desc = "item\(i)"
            c1Items.append(item)
        }
        c1Items.first?.choose = true//验证reset
        condition1.origin = c1Items
        
        let condition2 = SelectFilterCondition()
        condition2.title = "条件2"
        condition2.key = "条件2"
        condition2.configuration = configuration
        condition2.type = .singleChoice
        condition2.cellIdentifier = SelectFilterItemViewCell.identifier
        var c2Items = [DefaultConditionItem]()
        for i in 0...6 {
            let item = DefaultConditionItem()
            item.condition = "c\(i)"
            item.desc = "item\(i)"
            c2Items.append(item)
        }
        c2Items.last?.choose = true//验证reset
        condition2.origin = c2Items
        
        let condition3 = SelectFilterCondition()
        condition3.title = "条件3"
        condition3.key = "条件3"
        condition3.configuration = configuration
        condition3.type = .multipleChoice
        condition3.cellIdentifier = SelectFilterItemViewCell.identifier
        var c3Items = [DefaultConditionItem]()
        for i in 0...3 {
            let item = DefaultConditionItem()
            item.condition = "c\(i)"
            item.desc = "item\(i)"
            c3Items.append(item)
        }
        condition3.origin = c3Items
        
        let condition4 = InputFilterCondition()
        condition4.title = "条件4"
        condition4.key = "条件4"
        condition4.type = .input
        condition4.cellIdentifier = InputFilterCell.identifier
        
        let input = TextInputItem()
        input.placeHolder = "请输入条件4"
        condition4.input = input
        conditions = [condition1,condition2,condition3,condition4]
    }
    
    func configSubView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.footerReferenceSize = CGSize.zero
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView!.backgroundColor = UIColor.white
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(InputFilterCell.self, forCellWithReuseIdentifier: InputFilterCell.identifier)
        collectionView?.register(SelectFilterItemViewCell.self, forCellWithReuseIdentifier: SelectFilterItemViewCell.identifier)
        collectionView?.register(ListFilterHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ListFilterHeaderView.identifier)
        
        resetButton.backgroundColor = UIColor.blue
        confirmButton.backgroundColor = UIColor.red
        collectionView?.backgroundColor = UIColor.white
        
        resetButton.addTarget(self, action: #selector(self.reset), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(self.confirm), for: .touchUpInside)
        
        view.addSubview(collectionView!)
        view.addSubview(confirmButton)
        view.addSubview(resetButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = view.frame.size.width
        let height = view.frame.size.height
        let buttonHeight: CGFloat = 44
        var statusBarHeight: CGFloat = 20
        var bottom: CGFloat = 0
        //iPhoneX
        if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436 {
            statusBarHeight = 44
            bottom = 35
        }
        
        resetButton.frame = CGRect(x: 0, y: height - buttonHeight - bottom, width: width/2, height: buttonHeight)
        confirmButton.frame = CGRect(x: width/2, y: height - buttonHeight - bottom, width: width/2, height: buttonHeight)
        collectionView?.frame = CGRect(x: 0, y: statusBarHeight, width: width, height: height - statusBarHeight - buttonHeight - bottom)
    }
    
}

extension DefaultFilterViewController: UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let condition = conditions[indexPath.section]
        switch condition.type! {
        case .multipleChoice,.singleChoice:
            return CGSize(width: view.frame.width/3 - 12, height: 25)
        case .input:
            return CGSize(width: view.frame.width, height: 30)
        case .range:
            return CGSize(width: view.frame.width, height: 30)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let condition = conditions[section]
        switch condition.type! {
        case .multipleChoice,.singleChoice:
            return UIEdgeInsets(top: 0, left: 8, bottom: 10, right: 8)
        default:
            return UIEdgeInsets.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let condition = conditions[indexPath.section]
        if kind == UICollectionElementKindSectionHeader {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ListFilterHeaderView.identifier, for: indexPath) as! ListFilterHeaderView
            view.condition = condition
            view.tapBlock = {
                collectionView.reloadData()           
            }
            return view
        } else {
            return UICollectionReusableView()
        }
    }
    
}
