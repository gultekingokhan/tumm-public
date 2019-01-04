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
    private let service: RatesServiceProtocol
    private var rates: [Rate] = []
    private var latestRates: [String: Double] = [:]
    
    init(service: RatesServiceProtocol) {
        self.service = service
    }
    
    func load() {
        notify(.updateTitle("Tumm"))
        
        service.fetchSavedRates { (response) in
   
            var _rates: [Rate] = []
            
            if response.rates.count == 0 { _rates = self.defaultRates() } else {
                _rates = response.rates
                
                //let presentation = ConverterRatesPresentation(rates: _rates)
                //self.notify(.showConverterRates(presentation))
            }

            var base = ""

            for rate in _rates {
                if rate.type == .SELL { base = rate.code }
            }
            
            if base.count == 0 { base = (_rates.first?.code)! }
            
            self.fetchLatestRates(base: base, completion: { (success) in
                
                self.notify(.showLoading(false))

                if success {
                    
                    _ = self.update(rates: _rates)
                    
                    self.rates = _rates
                    let presentation = ConverterRatesPresentation(rates: _rates)
                    self.notify(.showConverterRates(presentation))

                } else { /* TODO: Handle this. */ }
            })
        }
    }
    
    func updateRateValues(value: Double) {
        
        var _rates: [Rate] = []
        
        for rate in rates {
            let newValue = rate.value! * value
            let newRate = Rate(id: rate.id, code: rate.code, type: rate.type, name: rate.name)
            newRate.value = newValue
            _rates.append(newRate)
        }
        let presentation = ConverterRatesPresentation(rates: _rates)
        self.notify(.showUpdatedRates(presentation))
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
    
    func updateSavedCurrencies(with rateType: RateType, isUpdating: Bool, selectedRate: Rate?) {
        let currencyListService = RatesService()
        let viewModel = CurrencyListViewModel(service: currencyListService, rateType: rateType, isUpdating: isUpdating, selectedRate: selectedRate)
        delegate?.navigate(to: .currencyList(viewModel))
    }
    
    func defaultRates() -> [Rate] {
        // TODO: Get these rates from Code Data.
        let rateUSD = Rate(id: NSUUID().uuidString.lowercased(), code: "USD", type: .SELL, name: "United States dollar")
        let rateEUR = Rate(id: NSUUID().uuidString.lowercased(), code: "EUR", type: .BUY, name: "European Euro")
        
        CoreDataClient.save(rate: rateUSD) { (error) in }
        CoreDataClient.save(rate: rateEUR) { (error) in }

        return CoreDataClient.fetch()
    }
}
