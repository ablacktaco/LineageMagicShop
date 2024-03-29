//
//  ShopViewController.swift
//  LineageMagicShop
//
//  Created by 陳姿穎 on 2019/11/4.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let userData = UserData.shared
    
    var index: Int = 0
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var levelOneButton: UIButton!
    @IBOutlet var levelTwoButton: UIButton!
    @IBOutlet var levelThreeButton: UIButton!
    @IBOutlet var switchTableViewButton: UIButton!
    @IBOutlet var switchCollectionViewButton: UIButton!
    @IBOutlet var userMoney: UILabel!
    @IBOutlet var displayOfTable: UITableView!
    @IBOutlet var displayOfCollection: UICollectionView!
    
    @IBOutlet var alertView: UIView!
    @IBOutlet var purchaseView: UIView!
    @IBOutlet var moneyNotEnoughView: UIView!
    @IBOutlet var magicIcon: UIImageView!
    @IBOutlet var magicPrice: UILabel!
    @IBOutlet var purchaseMagicButton: UIButton!
    @IBOutlet var cancelPurchaseButton: UIButton!
    @IBOutlet var byebyeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        userData.levelTag = 0
        levelOneButton.backgroundColor = .lead
        switchTableViewButton.backgroundColor = .lead
        displayOfTable.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        displayOfCollection.isHidden = true
        alertView.isHidden = true
        settingAlertView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        userMoney.text = "$ \(userData.userMoney)"
    }
    
    // MARK: - Setting TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.magicData[userData.levelTag].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "magicDataCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ShopTableViewCell
        
        let data = userData.magicData[userData.levelTag][indexPath.row]
        
        cell.magicIcon?.image = UIImage(named: data.magicName)
        cell.magicName.text = data.magicName
        cell.magicPrice.text = "$ \(data.magicPrice)"
        cell.soldOutView.isHidden = data.purchaseState ? false : true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if userData.magicData[userData.levelTag][indexPath.row].purchaseState { return nil }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        showPurchaseView(indexPath)
    }
    
    // MARK: - Setting CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userData.magicData[userData.levelTag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 4, height: view.frame.width / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "magicDataCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ShopCollectionViewCell
        
        let data = userData.magicData[userData.levelTag][indexPath.row]
        
        cell.magicIcon?.image = UIImage(named: data.magicName)
        cell.soldOutView.isHidden = data.purchaseState ? false : true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath.row
        showPurchaseView(indexPath)
    }
    
    // MARK: - ShopView Action
    
    @IBAction func ShowLevelOneMagic(_ sender: UIButton) {
        userData.levelTag = 0
        resetLevelButtonColor(sender)
        reloadTableOrCollection()
    }
    @IBAction func ShowLevelTwoMagic(_ sender: UIButton) {
        userData.levelTag = 1
        resetLevelButtonColor(sender)
        reloadTableOrCollection()
    }
    @IBAction func ShowLevelThreeMagic(_ sender: UIButton) {
        userData.levelTag = 2
        resetLevelButtonColor(sender)
        reloadTableOrCollection()
    }
    
    @IBAction func ShowTableViewState(_ sender: UIButton) {
        displayOfCollection.isHidden = true
        displayOfTable.isHidden = false
        resetViewButtonColor(sender)
        displayOfTable.reloadData()
    }
    @IBAction func ShowCollectionViewState(_ sender: UIButton) {
        displayOfTable.isHidden = true
        displayOfCollection.isHidden = false
        resetViewButtonColor(sender)
        displayOfCollection.reloadData()
    }
    
    // MARK: - AlertView Action
    
    @IBAction func toPurchaseMagic(_ sender: UIButton) {
        userData.userMoney -= userData.magicData[userData.levelTag][index].magicPrice
        userData.magicData[userData.levelTag][index].purchaseState.toggle()
        hideAlertView()
        viewWillAppear(false)
        reloadTableOrCollection()
    }
    @IBAction func cancelPurchaseMagic(_ sender: UIButton) {
        hideAlertView()
    }
    @IBAction func byebyeAction(_ sender: UIButton) {
        hideAlertView()
    }
    
    // MARK: - Addition Function
    
    fileprivate func resetLevelButtonColor(_ sender: UIButton) {
        levelOneButton.backgroundColor = .darkGray
        levelTwoButton.backgroundColor = .darkGray
        levelThreeButton.backgroundColor = .darkGray
        sender.backgroundColor = .lead
    }
    
    fileprivate func resetViewButtonColor(_ sender: UIButton) {
        switchTableViewButton.backgroundColor = .darkGray
        switchCollectionViewButton.backgroundColor = .darkGray
        sender.backgroundColor = .lead
    }
    
    fileprivate func reloadTableOrCollection() {
        if displayOfTable.isHidden {
            displayOfCollection.reloadData()
        } else {
            displayOfTable.reloadData()
        }
    }
    
    fileprivate func settingAlertView() {
        alertView.addSubview(purchaseView)
        purchaseView.center = CGPoint(x: alertView.frame.width / 2, y: alertView.frame.height / 2)
        alertView.addSubview(moneyNotEnoughView)
        moneyNotEnoughView.center = CGPoint(x: alertView.frame.width / 2, y: alertView.frame.height / 2)
        set(button: purchaseMagicButton, configSetting: .purchaseButtonSetting)
        set(button: cancelPurchaseButton, configSetting: .purchaseButtonSetting)
        set(button: byebyeButton, configSetting: .purchaseButtonSetting)
    }
    
    fileprivate func showPurchaseView(_ indexPath: IndexPath) {
        let data = userData.magicData[userData.levelTag][indexPath.row]
        mainView.isUserInteractionEnabled = false
        alertView.isHidden = false
        if userData.userMoney >= data.magicPrice {
            purchaseView.isHidden = false
            moneyNotEnoughView.isHidden = true
            magicIcon.image = UIImage(named: data.magicName)
            magicPrice.text = "$ \(data.magicPrice)"
        } else {
            purchaseView.isHidden = true
            moneyNotEnoughView.isHidden = false
        }
    }
    
    fileprivate func hideAlertView() {
        alertView.isHidden = true
        mainView.isUserInteractionEnabled = true
    }
    
}

