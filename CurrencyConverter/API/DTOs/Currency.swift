//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 13.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import Foundation

public struct Currency {
    
    let symbol: String
    let value: Double
    let country: Country
    var isAdded: Bool?
    
    init(symbol: String, value: Double, country: Country) {
        self.symbol = symbol
        self.value = value
        self.country = country
    }
}
