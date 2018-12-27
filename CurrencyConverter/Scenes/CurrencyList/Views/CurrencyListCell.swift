//
//  CurrencyListCell.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 24.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import UIKit

public final class CurrencyListCell: UITableViewCell {
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    public override func awakeFromNib() {
        update(themeColor: UIColor.lightSalmon)
    }
    
    public func update(themeColor: UIColor) {
        symbolLabel.textColor = themeColor
    }
}
