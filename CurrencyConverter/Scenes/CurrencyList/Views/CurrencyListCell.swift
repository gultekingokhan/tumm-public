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
    @IBOutlet weak var actionButton: ActionButton!

    public override func awakeFromNib() {
        update(themeColor: UIColor.lightSalmon)
    }
    
    public func update(themeColor: UIColor) {
        symbolLabel.textColor = themeColor
    }
    
    public func load(currency: Currency) {
        
        symbolLabel.text = currency.symbol
        nameLabel.text = currency.country.name
        
        if currency.isAdded == true {
            actionButton.update(actionType: .Remove)
        } else {
            actionButton.update(actionType: .Add)
        }
    }
}
