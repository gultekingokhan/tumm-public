//
//  GradientPlusButton.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 26.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import UIKit

final class ActionButton: UIButton {
    
    enum ActionType {
        case Add
        case Remove
    }
    
    private var gradientLayer:CAGradientLayer!
    private var iconView: UIImageView!
    public var actionType: ActionType?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {

        self.actionType = .Add

        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.salmonPink.cgColor, UIColor.purpleishPinkTwo.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = bounds
        
        layer.addSublayer(gradientLayer)
        
        iconView = UIImageView(frame: bounds)
        iconView.image = UIImage(named: "plusIcon")
        iconView.contentMode = UIView.ContentMode.center
        addSubview(iconView)
        
        layer.masksToBounds = true
        roundCorners(radius: 4)
    }
    
    public func update(actionType: ActionType) {
        self.actionType = actionType
        switch actionType {
        case .Add:
            
            layer.addSublayer(gradientLayer)
            backgroundColor = UIColor.clear
            iconView.image = UIImage(named: "plusIcon")
            
        case .Remove:
            
            gradientLayer.removeFromSuperlayer()
            backgroundColor = UIColor.darkTwo
            iconView.image = UIImage(named: "minusIcon")
        }
        bringSubviewToFront(iconView)
    }
}
