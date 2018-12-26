//
//  ConverterRatesPresentation.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 25.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import Foundation

final class ConverterRatesPresentation: NSObject {
    
    let rates: [String: [Rate]]
    
    init(rates: [Rate]) {
        
        var output: [String: [Rate]] = [:]
        
        var buyRates: [Rate] = []
        var sellRates: [Rate] = []
        
        for rate in rates {
            
            if rate.type == .BUY {
                buyRates.append(rate)
            } else {
                sellRates.append(rate)
            }
        }
        
        output.updateValue(sellRates, forKey: "SELL")
        output.updateValue(buyRates, forKey: "BUY")

        self.rates = output

        super.init()
    }
}
