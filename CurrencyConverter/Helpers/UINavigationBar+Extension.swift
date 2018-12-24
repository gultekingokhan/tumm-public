//
//  UINavigationBar+Extension.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 24.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    func customize() {
        
        self.prefersLargeTitles = true
        self.barTintColor = UIColor.lightBackgroundColor
        self.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        self.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]

    }
}
