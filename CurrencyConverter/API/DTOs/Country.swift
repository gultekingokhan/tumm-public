//
//  Country.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 20.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import Foundation

public struct Country: Decodable {
    
    public let cc: String
    public let symbol: String
    public let name: String
    
    init(cc: String, symbol: String, name: String) {
        self.cc = cc
        self.symbol = symbol
        self.name = name
    }
}
