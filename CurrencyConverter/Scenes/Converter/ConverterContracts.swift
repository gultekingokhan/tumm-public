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
}

enum ConverterViewModelOutput {
    case showLoading(Bool)
    case showLatestRates(ConverterPresentation)
}

protocol ConverterViewModelDelegate: class {
    func handleViewModelOutput(_ output: ConverterViewModelOutput)
}
