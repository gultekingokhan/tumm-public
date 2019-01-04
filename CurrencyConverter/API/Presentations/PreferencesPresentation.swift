//
//  PreferencesPresentation.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 4.01.2019.
//  Copyright © 2019 Gokhan Gultekin. All rights reserved.
//

import Foundation

final class PreferencesPresentation: NSObject {
    
    let list: [String]
    
    init(list: [String]) {
        self.list = list
        super.init()
    }
}
