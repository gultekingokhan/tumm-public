//
//  LatesRatesService.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 13.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import Foundation

public protocol RatesServiceProtocol {

    func fetchLatestRates(base: String, completion: @escaping (Result<LatestRatesResponse>) -> Void)
    func fetchSavedRates(completion: @escaping (_ response: ConverterRatesResponse) -> Void)
}

public class RatesService: RatesServiceProtocol {

    public enum Error: Swift.Error {
        case serializationError(internal: Swift.Error)
        case networkError(internal: Swift.Error)
    }
    
    public init() { }
    
    public func fetchLatestRates(base: String, completion: @escaping (Result<LatestRatesResponse>) -> Void) {

        let params = ["base":base]
        
        HTTPClient.get(from: HTTPClient.makeURL(with: .latest), params: params) { (response) in
            
            switch response.result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(LatestRatesResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(Error.serializationError(internal: error)))
                }
            case .failure(let error):
                completion(.failure(Error.networkError(internal: error)))
            }
        }
    }
    
    public func fetchSavedRates(completion: @escaping (_ response: ConverterRatesResponse) -> Void) {
        
        let rates = CoreDataClient.fetch()
        completion(ConverterRatesResponse(rates: rates))
    }
}
