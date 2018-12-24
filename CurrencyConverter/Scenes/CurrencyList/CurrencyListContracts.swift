//
//  CurrencyListContracts.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 14.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import Foundation

protocol CurrencyListViewModelProtocol {
    var delegate: CurrencyListViewModelDelegate? { get set }
    func load(base: String)
}

enum CurrencyListViewModelOutput {
    case updateTitle(String)
    case showLoading(Bool)
    case showLatestRates(CurrencyListPresentation)
}

enum CurrencyListViewRoute {
    //case currencyList(CurrencyListViewModelProtocol)
}

protocol CurrencyListViewModelDelegate: class {
    func handleViewModelOutput(_ output: CurrencyListViewModelOutput)
}
