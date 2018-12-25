//
//  Rate.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 25.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import Foundation

public enum RateType: String {
    case Sell
    case Buy
}

final class Rate: NSObject {
    
    var id: String
    var code: String
    var type: RateType
    var name: String
    
    init(id: String, code: String, type: RateType, name: String) {
        self.id = id
        self.code = code
        self.type = type
        self.name = name
    }
}
