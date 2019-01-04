//
//  PreferencesContracts.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 3.01.2019.
//  Copyright © 2019 Gokhan Gultekin. All rights reserved.
//

import UIKit

protocol PreferencesViewModelProtocol {
    var delegate: PreferencesViewModelDelegate? { get set }
    func load()
    func openTwitterProfile()
    func rateApp()
    func shareApp()
    func aboutApp()
}

enum PreferencesViewModelOutput {
    case updateTitle(String)
    case showList(PreferencesPresentation)
    case updateVersionLabel(String)
    case presentActivityController(UIActivityViewController)
}

protocol PreferencesViewModelDelegate: class {
    func handleViewModelOutput(_ output: PreferencesViewModelOutput)
}
