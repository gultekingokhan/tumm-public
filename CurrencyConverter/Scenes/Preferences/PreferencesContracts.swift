//
//  PreferencesContracts.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 3.01.2019.
//  Copyright © 2019 Gokhan Gultekin. All rights reserved.
//

import Foundation

protocol PreferencesViewModelProtocol {
    var delegate: PreferencesViewModelDelegate? { get set }
    func load()
}

enum PreferencesViewModelOutput {
    case updateTitle(String)
}

protocol PreferencesViewModelDelegate: class {
    func handleViewModelOutput(_ output: PreferencesViewModelOutput)
}
