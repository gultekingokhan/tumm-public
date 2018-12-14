//
//  ConverterPresentation.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 14.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import Foundation

final class ConverterPresentation: NSObject {
    
    let base: String
    let date: String
    let rates: [Currency]
    
    init(base: String, date: String, rates: [String:Double]) {
        self.base = base
        self.date = date
        
        let symbols = [String](rates.keys)

        var currencies: [Currency] = []
        
        for symbol in symbols {
            if let value = rates[symbol]  {
                let currency = Currency(symbol: symbol, value: value)
                currencies.append(currency)
            }
        }
        self.rates = currencies
        super.init()
    }
}
