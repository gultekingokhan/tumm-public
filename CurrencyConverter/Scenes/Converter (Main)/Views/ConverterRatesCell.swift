//
//  ConverterRatesCell.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 25.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import UIKit

final class ConverterRatesCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var rateTextField: UITextField?
    @IBOutlet weak var arrowButton: UIButton!
    
    override func awakeFromNib() {
        containerView.roundCorners(radius: 6)
        containerView.dropShadow(with: UIColor.black)
    }
    
    public func loadData(indexPath: IndexPath, rate: Rate) {
        
        codeLabel?.text = rate.code
        
        var valueString = ""
        
        if let value = rate.value {
            valueString = String(format: "%.2f", value)
        }
        
        if indexPath.section == 0 {
            valueLabel.isHidden = true
            rateTextField?.isHidden = false
            rateTextField?.text = valueString
            codeLabel.textColor = UIColor.lightSalmon
            arrowButton.setImage(UIImage(named: "downOrg"), for: .normal)
        } else {
            valueLabel.isHidden = false
            rateTextField?.isHidden = true
            valueLabel?.text = valueString
            codeLabel.textColor = UIColor.purpleishPink
            arrowButton.setImage(UIImage(named: "downPurp"), for: .normal)
        }
    }
}
