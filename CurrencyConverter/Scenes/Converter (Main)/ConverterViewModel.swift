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
        notify(.showLoading(true))
        
        service.fetchSavedRates { [weak self] (response) in
            guard let self = self else { return }

            var _rates: [Rate] = []
            
            if response.rates.count == 0 {
                
                self.defaultRates(completion: { (defaultRates) in
                    _rates = defaultRates
                })
                
            } else {
                _rates = response.rates
            }

            var base = ""

            for rate in _rates {
                if rate.type == .SELL { base = rate.code }
            }
            
            if base.count == 0 { base = (_rates.first?.code)! }

            self.service.fetchLatestRates(base: base) { (result) in
                self.notify(.showLoading(false))
                
                switch result {
                case .success(let response):
                    
                    self.latestRates = response.rates
                    
                    _ = self.update(rates: _rates)
                    
                    self.rates = _rates
                    let presentation = ConverterRatesPresentation(rates: _rates)
                    self.notify(.showConverterRates(presentation))

                case .failure(let error):
                    print(error)
                }
            }
            return
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
    
    func defaultRates(completion:@escaping(_ rates: [Rate]) -> Void) {
        
        let rateUSD = Rate(id: NSUUID().uuidString.lowercased(), code: "USD", type: .SELL, name: "United States dollar")
        let rateEUR = Rate(id: NSUUID().uuidString.lowercased(), code: "EUR", type: .BUY, name: "European Euro")
       
        CoreDataClient.save(rate: rateUSD) { }
        CoreDataClient.save(rate: rateEUR) { }
        
        CoreDataClient.fetch(completion: { (rates) in
            completion(rates)
        })
    }
}
