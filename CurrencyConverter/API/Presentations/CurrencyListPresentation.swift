//
//  CurrencyListPresentation.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 20.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import Foundation

final class CurrencyListPresentation: NSObject {
    
    let base: String
    let date: String
    let rates: [Currency]
    
    init(base: String, date: String, rates: [String:Double]) {
        self.base = base
        self.date = date
        
        let symbols = [String](rates.keys)
        
        var currencies: [Currency] = []
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
                
                let currency = Currency(symbol: symbol, value: value, country: country)
                currencies.append(currency)
            }
        }
        
        self.rates = currencies
        super.init()
    }
}
