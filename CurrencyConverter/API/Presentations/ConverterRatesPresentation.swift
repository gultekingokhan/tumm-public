//
//  ConverterRatesPresentation.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 25.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import Foundation

final class ConverterRatesPresentation: NSObject {
    
    let rates: [Rate]
    
    init(rates: [Rate]) {
        self.rates = rates
        super.init()
    }
}
