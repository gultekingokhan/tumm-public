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
    let rates: [String: Double]
    
    init(base: String, date: String, rates: [String:Double]) {
        self.base = base
        self.date = date
        self.rates = rates
        super.init()
    }
}
