//
//  PreferencesViewModel.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 3.01.2019.
//  Copyright © 2019 Gokhan Gultekin. All rights reserved.
//

import Foundation

final class PreferencesViewModel: PreferencesViewModelProtocol {
    
    weak var delegate: PreferencesViewModelDelegate?
    
    private func notify(_ output: PreferencesViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
    
    func load() {
        notify(.updateTitle("Preferences"))
    }
}
