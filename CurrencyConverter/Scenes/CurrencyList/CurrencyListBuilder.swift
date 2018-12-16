//
//  CurrencyListBuilder.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 14.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import UIKit

final class CurrencyListBuilder {
    
    static func make() -> CurrencyListViewController {
        let storyboard = UIStoryboard(name: "CurrencyList", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CurrencyListViewController") as! CurrencyListViewController
        // viewController.viewModel = ...
        return viewController
    }
}
