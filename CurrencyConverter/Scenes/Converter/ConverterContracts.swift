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
    func load(base: String)
    func addCurrency()
}

enum ConverterViewModelOutput {
    case updateTitle(String)
    case showLoading(Bool)
    case showLatestRates(ConverterPresentation)
    case showConverterRates(ConverterRatesPresentation)
}

enum ConverterViewRoute {
    case currencyList(CurrencyListViewModelProtocol)
}

protocol ConverterViewModelDelegate: class {
    func handleViewModelOutput(_ output: ConverterViewModelOutput)
    func navigate(to route: ConverterViewRoute)
}
