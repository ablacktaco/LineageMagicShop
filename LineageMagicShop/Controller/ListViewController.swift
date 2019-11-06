//
//  ListViewController.swift
//  LineageMagicShop
//
//  Created by 陳姿穎 on 2019/11/5.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let userData = UserData.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return userData.magicData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userData.magicData[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableviewIdentifier = "sectionHeader"
        let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reusableviewIdentifier, for: indexPath) as! CollectionReusableView

        let headerTitles = ["Level One", "Level Two", "Level Three"]
        reusableview.headerTitle.text = headerTitles[indexPath.section]
        
        return reusableview
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 4, height: view.frame.width / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "magicIconCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ListCollectionViewCell

        let data = userData.magicData[indexPath.section][indexPath.row]
        
        cell.listMagicIcon.image = UIImage(named: data.magicName)
        cell.showPurchasedStateView.isHidden = data.purchaseState
        
        return cell
    }
    
}
