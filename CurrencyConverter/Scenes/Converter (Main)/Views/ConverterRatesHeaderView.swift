//
//  ConverterRatesHeaderView.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 26.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import UIKit

public final class ConverterRatesHeaderView: UIView {
    
    public var titleLabel: UILabel?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        
        titleLabel = UILabel(frame: CGRect(x: 16, y: 0, width: 120, height: frame.height))
        titleLabel?.textColor = UIColor.battleshipGrey
        titleLabel?.font = UIFont(name: "Avenir-Medium", size: 12)
        addSubview(titleLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
