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
    let rates: [Rate]
    
    init(base: String, date: String, rates: [String:Double]) {
        self.base = base
        self.date = date
        
        let symbols = [String](rates.keys)

        var currencies: [Rate] = []
        var countries: [Country] = []
        
        do {
            try ResourceLoader.loadCountries(success: { (response) in
                
                countries = response.countries
                
            }) { (error) in
                print(error)
            }
            
        } catch {
            print(error)
        }
        
        for symbol in symbols {
            if let value = rates[symbol]  {
                
                var country = Country(cc: symbol, symbol: "", name: "")
                for c in countries {
                    if symbol == c.cc {
                        country = c
                    }
                }
                
                let rate = Rate(value: value, code: symbol, type: .None, name: country.name)
                currencies.append(rate)
            }
        }
        self.rates = currencies
        super.init()
    }
}
