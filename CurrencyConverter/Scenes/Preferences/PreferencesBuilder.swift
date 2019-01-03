//
//  PreferencesBuilder.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 3.01.2019.
//  Copyright © 2019 Gokhan Gultekin. All rights reserved.
//

import UIKit

final class PreferencesBuilder {
    
    static func make() -> PreferencesViewController {
        let storyboard = UIStoryboard(name: "Preferences", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PreferencesViewController") as! PreferencesViewController
        viewController.viewModel = PreferencesViewModel()
        return viewController
    }
}
