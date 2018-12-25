//
//  UIView+Extension.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 25.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import UIKit

public extension UIView {
    
    public func roundCorners(radius: CGFloat) {
        layer.cornerRadius = radius
    }
    
    public func makeCircle() {
        layer.cornerRadius = self.frame.size.width/2
    }
    
    public func dropShadow(with color: UIColor) {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.16
        layer.shadowRadius = 12
        layer.shadowColor = color.cgColor
    }
}
