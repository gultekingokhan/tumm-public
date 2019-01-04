//
//  Credentials.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 13.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import Foundation

struct Constants {

    struct API {
        static let base_url = "https://api.exchangeratesapi.io/"
        static let api_key = ""
        static let headers: [String:String] = [:]
    }
    
    struct Links {
        static let appStore = "https://itunes.apple.com/app/id1447853257"
        static let medium = "https://medium.com/tumm"
        static let twitter_url = "https://twitter.com/tummapp"
        static let twitter_scheme = "twitter://user?screen_name=tummapp"
    }
}

struct UserDefaultsKeys {
    static let APP_OPENED_COUNT = "APP_OPENED_COUNT"
}
