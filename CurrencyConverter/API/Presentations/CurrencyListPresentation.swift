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
    let rates: Dictionary<String, [Currency]>
    
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
        
        let service = ConverterRatesService()
        
        service.fetchRates { (response) in
            
            var i = 0
            for currency in currencies {
                for rate in response.rates {
                    if currency.symbol == rate.code {
                        currencies[i].isAdded = true
                    }
                }
                i = i + 1
            }
        }
        self.rates = Dictionary(grouping: currencies, by: { String($0.symbol.first!) })
        
        super.init()
    }
}
