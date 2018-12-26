//
//  ConverterRatesFooterView.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 26.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import UIKit

protocol ConverterRatesFooterViewDelegate {
    func addCurrencyButtonTapped()
}

final class ConverterRatesFooterView: UIView {
    
    public var addCurrencyButton: GradientButton?
    public var delegate: ConverterRatesFooterViewDelegate?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        
        addCurrencyButton = GradientButton(frame: CGRect(x: 0, y: 0, width: 70, height: 34))
        addCurrencyButton?.addTarget(self, action: #selector(currencyButtonAction), for: .touchUpInside)
        addCurrencyButton!.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(addCurrencyButton!)
        addCurrencyButton!.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        addCurrencyButton!.widthAnchor.constraint(equalToConstant: 70).isActive = true
        addCurrencyButton!.heightAnchor.constraint(equalToConstant: 34).isActive = true
        addCurrencyButton!.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    @objc func currencyButtonAction() {
        delegate?.addCurrencyButtonTapped()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
