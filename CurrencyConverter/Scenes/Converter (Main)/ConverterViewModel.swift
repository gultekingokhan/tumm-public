//
//  ConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 14.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import Foundation

final class ConverterViewModel: ConverterViewModelProtocol {
    
    weak var delegate: ConverterViewModelDelegate?
    private let service: ConverterRatesServiceProtocol
    private var rates: ConverterRatesResponse? = nil

    init(service: ConverterRatesServiceProtocol) {
        self.service = service
    }
    
    func load(base: String) {
        notify(.updateTitle("Tumm"))
        notify(.showLoading(true))
        
        service.fetchRates { (response) in
   
            var _rates: [Rate] = []
            
            if response.rates.count == 0 { _rates = self.defaultRates() } else {
                _rates = response.rates
            }
            
            let presentation = ConverterRatesPresentation(rates: _rates)
            self.notify(.showConverterRates(presentation))
        }
    }
    
    private func notify(_ output: ConverterViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
    
    func addCurrency() {
        let currencyListService = RatesService()
        let viewModel = CurrencyListViewModel(service: currencyListService)
        delegate?.navigate(to: .currencyList(viewModel))
    }
    
    func defaultRates() -> [Rate] {
        // TODO: Get these rates from Code Data.
        let rateUSD = Rate(id: NSUUID().uuidString.lowercased(), code: "USD", type: .Sell, name: "United States dollar")
        let rateEUR = Rate(id: NSUUID().uuidString.lowercased(), code: "EUR", type: .Buy, name: "European Euro")
        
        CoreDataHelper.save(rate: rateUSD) { (error) in }
        CoreDataHelper.save(rate: rateEUR) { (error) in }

        return CoreDataHelper.fetch()
    }
}
