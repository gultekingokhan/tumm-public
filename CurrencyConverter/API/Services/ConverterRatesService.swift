//
//  ConverterRatesService.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 25.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import Foundation

protocol ConverterRatesServiceProtocol {
    
    func fetchRates(completion: @escaping (_ response: ConverterRatesResponse) -> Void)
}

public class ConverterRatesService: ConverterRatesServiceProtocol {
    
    public enum Error: Swift.Error {
        case serializationError(internal: Swift.Error)
        case networkError(internal: Swift.Error)
    }
    
    public init() { }
    
    public func fetchRates(completion: @escaping (_ response: ConverterRatesResponse) -> Void) {

        let rates = CoreDataClient.fetch()
        completion(ConverterRatesResponse(rates: rates))
    }
}
