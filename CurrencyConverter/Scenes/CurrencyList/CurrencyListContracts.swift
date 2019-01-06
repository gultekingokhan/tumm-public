//
//  CurrencyListContracts.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 14.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import Foundation
import UIKit

protocol CurrencyListViewModelProtocol {
    var themeColor: UIColor { get set }
    var isUpdating: Bool { get set }
    var selectedRate: Rate? { get set } 
    var delegate: CurrencyListViewModelDelegate? { get set }
    func load()
    func actionButtonTapped(rate: Rate, completion: @escaping(_ isAdded: Bool) -> Void)
}

enum CurrencyListViewModelOutput: Equatable {
    case updateTitle(String)
    case showLoading(Bool)
    case showLatestRates(CurrencyListPresentation)
}

enum CurrencyListViewRoute { }

protocol CurrencyListViewModelDelegate: class {
    func handleViewModelOutput(_ output: CurrencyListViewModelOutput)
}
