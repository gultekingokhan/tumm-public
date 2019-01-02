//
//  CurrencyListViewModel.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 14.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import Foundation
import UIKit

final class CurrencyListViewModel: CurrencyListViewModelProtocol {
    
    var themeColor: UIColor = UIColor.lightSalmon
    weak var delegate: CurrencyListViewModelDelegate?
    private let service: RatesServiceProtocol
    private var rates: LatestRatesResponse? = nil
    private let rateType: RateType
    
    init(service: RatesServiceProtocol, rateType: RateType) {
        self.service = service
        self.rateType = rateType
    }
    
    func load(base: String) {

        if rateType == .BUY { themeColor = UIColor.purpleishPink }
        
        let rateTypeLowercased = rateType.rawValue.lowercased()
        notify(.updateTitle("Choose your \(rateTypeLowercased) currency"))
        notify(.showLoading(true))
        
        service.fetchLatestRates(base: base) { (result) in
            self.notify(.showLoading(false))
            
            switch result {
            case .success(let response):
                self.rates = response
                let presentation = CurrencyListPresentation(base: response.base, date: response.date, rates: response.rates)
                self.notify(.showLatestRates(presentation))
            case .failure(let error):
                print(error) // TODO: Handle this.
            }
        }
    }
    
    private func notify(_ output: CurrencyListViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
    
    public func convert(from symbol: String) -> String {
        return ""
    }
    
    func actionButtonTapped(rate: Rate, completion: @escaping (Bool) -> Void) {
        
        if rate.isAdded == true {
            
            CoreDataClient.remove(rate: rate)
            
        } else {
            rate.type = .BUY
            CoreDataClient.save(rate: rate) { (error) in }
        }
        
        completion(!rate.isAdded!)
    }
}
