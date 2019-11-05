//
//  ShopTableViewCell.swift
//  LineageMagicShop
//
//  Created by 陳姿穎 on 2019/11/4.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import UIKit

class ShopTableViewCell: UITableViewCell {

    @IBOutlet var magicIcon: UIImageView!
    @IBOutlet var magicName: UILabel!
    @IBOutlet var magicPrice: UILabel!
    @IBOutlet var soldOutView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
