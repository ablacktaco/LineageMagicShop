//
//  UserData.swift
//  LineageMagicShop
//
//  Created by 陳姿穎 on 2019/11/4.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import Foundation

class UserData {
    
    static let shared = UserData()

    var levelTag = 0
    static let defaultMagicData: [[MagicData]] = [
        
        [MagicData(magicName: "保護罩", magicPrice: 100, purchaseState: false),
         MagicData(magicName: "光箭", magicPrice: 100, purchaseState: false),
         MagicData(magicName: "冰箭", magicPrice: 100, purchaseState: false),
         MagicData(magicName: "初級治癒術", magicPrice: 100, purchaseState: false),
         MagicData(magicName: "指定傳送", magicPrice: 100, purchaseState: false),
         MagicData(magicName: "日光術", magicPrice: 100, purchaseState: false),
         MagicData(magicName: "神聖武器", magicPrice: 100, purchaseState: false),
         MagicData(magicName: "風刃", magicPrice: 100, purchaseState: false)],
        
        [MagicData(magicName: "地獄之牙", magicPrice: 200, purchaseState: false),
         MagicData(magicName: "寒冷戰慄", magicPrice: 200, purchaseState: false),
         MagicData(magicName: "擬似魔法武器", magicPrice: 200, purchaseState: false),
         MagicData(magicName: "毒咒", magicPrice: 200, purchaseState: false),
         MagicData(magicName: "火箭", magicPrice: 200, purchaseState: false),
         MagicData(magicName: "無所遁形術", magicPrice: 200, purchaseState: false),
         MagicData(magicName: "解毒術", magicPrice: 200, purchaseState: false),
         MagicData(magicName: "負重強化", magicPrice: 200, purchaseState: false)],
        
        [MagicData(magicName: "中級治癒術", magicPrice: 300, purchaseState: false),
         MagicData(magicName: "寒冰氣息", magicPrice: 300, purchaseState: false),
         MagicData(magicName: "極光雷電", magicPrice: 300, purchaseState: false),
         MagicData(magicName: "能量感測", magicPrice: 300, purchaseState: false),
         MagicData(magicName: "起死回生術", magicPrice: 300, purchaseState: false),
         MagicData(magicName: "鎧甲護持", magicPrice: 300, purchaseState: false),
         MagicData(magicName: "闇盲咒術", magicPrice: 300, purchaseState: false)]
        
    ]
    
    var magicData: [[MagicData]] {
        didSet {
            if let data = try? PropertyListEncoder().encode(self.magicData) {
                UserDefaults.standard.set(data, forKey: "magicData")
            }
        }
    }
    private static func getMagicData() -> [[MagicData]] {
        if let magicData = UserDefaults.standard.object(forKey: "magicData") as? Data {
            if let data = try? PropertyListDecoder().decode([[MagicData]].self, from: magicData) {
                return data
            }
        }
        return defaultMagicData
    }
    
    var userMoney: Int {
        didSet {
            UserDefaults.standard.set(self.userMoney, forKey: "userMoney")
        }
    }
    private static func getUserMoney() -> Int {
        if let data = UserDefaults.standard.value(forKey: "userMoney") as? Int {
            return data
        }
        return 2000
    }
    
    private init() {
        userMoney = UserData.getUserMoney()
        magicData = UserData.getMagicData()
    }
    
}
