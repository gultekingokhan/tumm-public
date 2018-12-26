//
//  GradientPlusButton.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 26.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import UIKit

final class GradientButton: UIButton {
    
    private var gradientLayer:CAGradientLayer!
    private var plusImageView: UIImageView!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {

        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.salmonPink.cgColor, UIColor.purpleishPinkTwo.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = bounds
    
        self.layer.addSublayer(self.gradientLayer)

        plusImageView = UIImageView(frame: bounds)
        plusImageView.image = UIImage(named: "plusIcon")
        plusImageView.contentMode = UIView.ContentMode.center
        
        self.addSubview(plusImageView)
        
        layer.masksToBounds = true
        roundCorners(radius: 4)
    }
}
