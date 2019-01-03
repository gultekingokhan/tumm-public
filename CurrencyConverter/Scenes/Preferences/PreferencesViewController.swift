//
//  PreferencesViewController.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 3.01.2019.
//  Copyright © 2019 Gokhan Gultekin. All rights reserved.
//

import UIKit

final class PreferencesViewController: UIViewController {
    
    var viewModel: PreferencesViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
    }
}

extension PreferencesViewController: PreferencesViewModelDelegate {
    
    func handleViewModelOutput(_ output: PreferencesViewModelOutput) {
        switch output {
        case .updateTitle(let title):
            self.title = title
        }
    }
}
