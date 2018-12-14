//
//  LatesRatesService.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 13.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import Foundation

public protocol LatestRatesServiceProtocol {

    func fetchLatestRates(base: String, completion: @escaping (Result<LatestRatesResponse>) -> Void)
}

public class LatestRatesService: LatestRatesServiceProtocol {

    public enum Error: Swift.Error {
        case serializationError(internal: Swift.Error)
        case networkError(internal: Swift.Error)
    }
    
    public init() { }
    
    public func fetchLatestRates(base: String, completion: @escaping (Result<LatestRatesResponse>) -> Void) {

        let params = ["base":base, "symbols": "USD,GBP"]
        
        ServiceManager.get(from: ServiceManager.makeURL(with: .latest), params: params) { (response) in
            
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
}
