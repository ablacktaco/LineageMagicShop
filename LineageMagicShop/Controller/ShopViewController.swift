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
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var userMoney: UILabel!
    @IBOutlet var displayOfTable: UITableView!
    @IBOutlet var displayOfCollection: UICollectionView!
    
    @IBOutlet var alertView: UIView!
    @IBOutlet var purchaseView: UIView!
    @IBOutlet var moneyNotEnoughView: UIView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.magicData[userData.levelTag].count
    }
    
    fileprivate func judgePurchaseState(_ data: MagicData, _ cell: ShopTableViewCell) {
        if data.purchaseState {
            cell.soldOutView.isHidden = false
        } else {
            cell.soldOutView.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "magicDataCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ShopTableViewCell
        
        let data = userData.magicData[userData.levelTag][indexPath.row]
        
        cell.magicIcon?.image = UIImage(named: data.magicName)
        cell.magicName.text = data.magicName
        cell.magicPrice.text = "$ \(data.magicPrice)"
        judgePurchaseState(data, cell)
        
        return cell
    }
    
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
        if data.purchaseState {
            cell.soldOutView.isHidden = false
        } else {
            cell.soldOutView.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if userData.magicData[userData.levelTag][indexPath.row].purchaseState {
            return nil
        }
        return indexPath
    }
    
    var index: Int = 0
    @IBOutlet var magicIcon: UIImageView!
    @IBOutlet var magicPrice: UILabel!
    @IBOutlet var purchaseMagicButton: UIButton!
    @IBAction func toPurchaseMagic(_ sender: UIButton) {
        userData.userMoney -= userData.magicData[userData.levelTag][index].magicPrice
        userData.magicData[userData.levelTag][index].purchaseState.toggle()
        alertView.isHidden = true
        mainView.isUserInteractionEnabled = true
        viewWillAppear(false)
        reloadTableOrCollection()
    }
    @IBOutlet var cancelPurchaseButton: UIButton!
    @IBAction func cancelPurchaseMagic(_ sender: UIButton) {
        alertView.isHidden = true
        mainView.isUserInteractionEnabled = true
    }
    @IBOutlet var byebyeButton: UIButton!
    @IBAction func byebyeAction(_ sender: UIButton) {
        alertView.isHidden = true
        mainView.isUserInteractionEnabled = true
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        showPurchaseView(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath.row
        showPurchaseView(indexPath)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userData.levelTag = 0
        levelOneButton.backgroundColor = UIColor(red: 33.0/255.0, green: 33.0/255.0, blue: 33.0/255.0, alpha: 1.0)
        switchTableViewButton.backgroundColor = UIColor(red: 33.0/255.0, green: 33.0/255.0, blue: 33.0/255.0, alpha: 1.0)
        
        displayOfTable.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        displayOfCollection.isHidden = true
        alertView.isHidden = true
        settingAlertView()
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        userMoney.text = "$ \(userData.userMoney)"
    }
    
    fileprivate func reloadTableOrCollection() {
        if displayOfTable.isHidden {
            displayOfCollection.reloadData()
        } else {
            displayOfTable.reloadData()
        }
    }
    
    fileprivate func resetLevelButtonColor(_ sender: UIButton) {
        levelOneButton.backgroundColor = .darkGray
        levelTwoButton.backgroundColor = .darkGray
        levelThreeButton.backgroundColor = .darkGray
        sender.backgroundColor = UIColor(red: 33.0/255.0, green: 33.0/255.0, blue: 33.0/255.0, alpha: 1.0)
    }
    
    @IBOutlet var levelOneButton: UIButton!
    @IBAction func ShowLevelOneMagic(_ sender: UIButton) {
        userData.levelTag = 0
        resetLevelButtonColor(sender)
        reloadTableOrCollection()
    }
    @IBOutlet var levelTwoButton: UIButton!
    @IBAction func ShowLevelTwoMagic(_ sender: UIButton) {
        userData.levelTag = 1
        resetLevelButtonColor(sender)
        reloadTableOrCollection()
    }
    @IBOutlet var levelThreeButton: UIButton!
    @IBAction func ShowLevelThreeMagic(_ sender: UIButton) {
        userData.levelTag = 2
        resetLevelButtonColor(sender)
        reloadTableOrCollection()
    }
    
    fileprivate func resetViewButtonColor(_ sender: UIButton) {
        switchTableViewButton.backgroundColor = .darkGray
        switchCollectionViewButton.backgroundColor = .darkGray
        sender.backgroundColor = UIColor(red: 33.0/255.0, green: 33.0/255.0, blue: 33.0/255.0, alpha: 1.0)
    }
    
    @IBOutlet var switchTableViewButton: UIButton!
    @IBAction func ShowTableViewState(_ sender: UIButton) {
        displayOfCollection.isHidden = true
        displayOfTable.isHidden = false
        resetViewButtonColor(sender)
        displayOfTable.reloadData()
    }
    @IBOutlet var switchCollectionViewButton: UIButton!
    @IBAction func ShowCollectionViewState(_ sender: UIButton) {
        displayOfTable.isHidden = true
        displayOfCollection.isHidden = false
        resetViewButtonColor(sender)
        displayOfCollection.reloadData()
    }
    
}
