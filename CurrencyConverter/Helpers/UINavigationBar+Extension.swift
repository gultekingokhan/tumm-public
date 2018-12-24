//
//  UINavigationBar+Extension.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 24.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    func customize(supportsLargeTitle: Bool) {
 
        self.isTranslucent = false
        self.prefersLargeTitles = supportsLargeTitle
        self.barTintColor = UIColor.darkBackgroundColor
        self.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont(name: "Avenir-Book", size: 13)!]
        self.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont(name: "Avenir-Heavy", size: 34)!]
    }
}
