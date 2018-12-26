//
//  Credentials.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 13.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import Foundation

struct Credentials {
    
    struct API {
        static let base_url = "https://api.exchangeratesapi.io/"
        static let api_key = ""
        static let headers: [String:String] = [:]
    }
}
/*
struct Base {
    
    private enum Keys: String {
        case BaseCurrency
    }
    
    func setBase(currency: String) {
        UserDefaults.standard.string(forKey: Keys.BaseCurrency.rawValue)
    }
    
    func currency() -> String {
        
        let baseCurrency = UserDefaults.standard.string(forKey: Keys.BaseCurrency.rawValue)
        if  baseCurrency == nil {
            setBase(currency: "USD")
        }
        return baseCurrency
    }
}
*/
