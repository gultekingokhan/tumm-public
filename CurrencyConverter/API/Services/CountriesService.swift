//
//  CountriesService.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 20.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import Foundation

public protocol CountriesServiceProtocol {
    
    func fetchCountries(completion: @escaping (Result<[CountriesResponse]>) -> Void)
}

public class CountriesService: CountriesServiceProtocol {
    
    public enum Error: Swift.Error {
        case parseError(internal: Swift.Error)
    }
    
    public init() { }
    
    public func fetchCountries(completion: @escaping (Result<[CountriesResponse]>) -> Void) {

//        let response = ResourceLoader.loadCountries(success: <#(CountriesResponse) -> Void#>)
//        completion(.success(response))
    }
    
    /*
    public func fetchLatestRates(base: String, completion: @escaping (Result<LatestRatesResponse>) -> Void) {
        
        let params = ["base":base]
        
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
 */
}

