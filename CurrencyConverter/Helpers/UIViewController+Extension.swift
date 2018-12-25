//
//  BaseViewController.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 24.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    func addDismissButton() {
        let dismissButtonItem = UIBarButtonItem(image: UIImage(named: "close"), style: .plain, target: self, action: #selector(close))
        dismissButtonItem.tintColor = UIColor.rosyPink
        navigationItem.leftBarButtonItem = dismissButtonItem
    }
    
    func addSettingsButton() {
        let settingsButtonItem = UIBarButtonItem(image: UIImage(named: "settingsIcon"), style: .plain, target: self, action: #selector(emptyTask))
        settingsButtonItem.tintColor = UIColor.rosyPink
        navigationItem.rightBarButtonItem = settingsButtonItem
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func emptyTask() { }
}
