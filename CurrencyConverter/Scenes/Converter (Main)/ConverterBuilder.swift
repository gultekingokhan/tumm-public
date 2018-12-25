//
//  ConverterBuilder.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 13.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import UIKit

final class ConverterBuilder {
    
    static func make() -> ConverterViewController {
        let storyboard = UIStoryboard(name: "Converter", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ConverterViewController") as! ConverterViewController
        viewController.viewModel = ConverterViewModel(service: app.converterRatesService)
        return viewController
    }
}
