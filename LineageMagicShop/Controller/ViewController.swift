//
//  ViewController.swift
//  LineageMagicShop
//
//  Created by 陳姿穎 on 2019/11/4.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let userData = UserData.shared
    
    let correctList: [Bool] = [true, true, false, true, true, false, false]
    var answerList: [Bool] = []
    
    @IBAction func addTrue(_ sender: UIButton) {
        if answerList.count < 7 {
            answerList.append(true)
        } else {
            answerList.remove(at: 0)
            answerList.append(true)
        }
    }
    @IBAction func addFalse(_ sender: UIButton) {
        if answerList.count < 7 {
            answerList.append(false)
        } else {
            answerList.remove(at: 0)
            answerList.append(false)
            if answerList == correctList {
                userData.userMoney += 100
                viewWillAppear(false)
            }
        }
    }
    @IBOutlet var userMoney: UILabel!
    @IBOutlet var enterShopButton: UIButton!
    @IBOutlet var magicListButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        set(button: enterShopButton, configSetting: .mainPageButtonSetting)
        set(button: magicListButton, configSetting: .mainPageButtonSetting)
    }

    override func viewWillAppear(_ animated: Bool) {
        
        userMoney.text = "\(userData.userMoney)"
        super.viewWillAppear(animated)
    }
    
}
