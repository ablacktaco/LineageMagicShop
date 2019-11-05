//
//  SettingButtonProperties.swift
//  LineageMagicShop
//
//  Created by 陳姿穎 on 2019/11/5.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import UIKit

struct SettingButtonProperties {
    static let mainPageButtonSetting = SettingButtonProperties(cornerRadius: 10, bordercolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), borderWidth: 2.0, clipsToBounds: true)
    static let purchaseButtonSetting = SettingButtonProperties(cornerRadius: 10, bordercolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), borderWidth: 0.5, clipsToBounds: true)
    var cornerRadius: Double
    var bordercolor: CGColor
    var borderWidth: Double
    var clipsToBounds: Bool
}

// DI
func set(button: UIButton, configSetting: SettingButtonProperties) {
    button.layer.cornerRadius = CGFloat(configSetting.cornerRadius)
    button.layer.borderColor = configSetting.bordercolor
    button.layer.borderWidth = CGFloat(configSetting.borderWidth)
    button.clipsToBounds = configSetting.clipsToBounds
}
