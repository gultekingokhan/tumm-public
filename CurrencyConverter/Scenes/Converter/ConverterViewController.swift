//
//  ConverterViewController.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 13.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import UIKit

final class ConverterViewController: UIViewController {

    var viewModel: ConverterViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.load()
    }
}

extension ConverterViewController: ConverterViewModelDelegate {
    
    func handleViewModelOutput(_ output: ConverterViewModelOutput) {
        
        switch output {
        case .showLoading(let isLoading):
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        case .showLatestRates(let rates):
            print("Success!: \(rates)")
        }
    }
}
