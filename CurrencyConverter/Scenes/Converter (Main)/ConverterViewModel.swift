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
    private var latestRates: [String: Double] = [:]
    
    init(service: ConverterRatesServiceProtocol) {
        self.service = service
    }
    
    func load(base: String) {
        notify(.updateTitle("Tumm"))
        
        service.fetchRates { (response) in
   
            var _rates: [Rate] = []
            
            if response.rates.count == 0 { _rates = self.defaultRates() } else {
                _rates = response.rates
            }
            
            self.fetchLatestRates(base: base, completion: { (success) in
                
                self.notify(.showLoading(false))

                if success {
                    
                    _ = self.update(rates: _rates)
                    
                    let presentation = ConverterRatesPresentation(rates: _rates)
                    self.notify(.showConverterRates(presentation))

                } else { /* TODO: Handle this. */ }
            })
        }
    }
    
    private func fetchLatestRates(base: String, completion: @escaping(_ success: Bool) ->Void) {

        notify(.showLoading(true))
        
        let ratesService = RatesService()
        
        ratesService.fetchLatestRates(base: base) { (result) in
            self.notify(.showLoading(false))
            
            switch result {
            case .success(let response):

                self.latestRates = response.rates
        
                completion(true)

            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    private func update(rates: [Rate]) -> [Rate] {
        
        for localRate in rates {
            
            for remoteRate in latestRates {
                
                if localRate.code == remoteRate.key {
                    localRate.value = remoteRate.value
                }
            }
        }
        return rates
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
        let rateUSD = Rate(id: NSUUID().uuidString.lowercased(), code: "USD", type: .SELL, name: "United States dollar")
        let rateEUR = Rate(id: NSUUID().uuidString.lowercased(), code: "EUR", type: .BUY, name: "European Euro")
        
        CoreDataHelper.save(rate: rateUSD) { (error) in }
        CoreDataHelper.save(rate: rateEUR) { (error) in }

        return CoreDataHelper.fetch()
    }
}
