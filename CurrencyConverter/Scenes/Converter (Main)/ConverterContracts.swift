//
//  ConverterContracts.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 14.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import Foundation

protocol ConverterViewModelProtocol {
    var delegate: ConverterViewModelDelegate? { get set }
    func load()
    func updateSavedCurrencies(with rateType: RateType, isUpdating: Bool, selectedRate: Rate?)
    func updateRateValues(value: Double)
}

enum ConverterViewModelOutput {
    case updateTitle(String)
    case showLoading(Bool)
    case showLatestRates(ConverterPresentation)
    case showConverterRates(ConverterRatesPresentation)
    case showUpdatedRates(ConverterRatesPresentation)
}

enum ConverterViewRoute {
    case currencyList(CurrencyListViewModelProtocol)
    case preferences()
}

protocol ConverterViewModelDelegate: class {
    func handleViewModelOutput(_ output: ConverterViewModelOutput)
    func navigate(to route: ConverterViewRoute)
    func check(string: String) -> Bool
}
