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
    
    init(symbol: String, value: Double) {
        self.symbol = symbol
        self.value = value
    }
}
