//
//  ResourceLoader.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 20.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import Foundation

public enum RLError: Swift.Error {
    case parseError(internal: Swift.Error)
}

protocol ResourceLoaderProtocol {
    static func loadCountries(success: @escaping (CountriesResponse) -> Void, failure: @escaping (RLError) -> Void) throws
}

final class ResourceLoader: ResourceLoaderProtocol {
    
    static func loadCountries(success: @escaping (CountriesResponse) -> Void, failure: @escaping (RLError) -> Void) throws {
       
        let path = Bundle.main.path(forResource: "countries", ofType: "json")
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
            let response = try JSONDecoder().decode(CountriesResponse.self, from: data)
            success(response)
            
        } catch let error {
            failure(RLError.parseError(internal: error))
        }
    }
}

private extension Bundle {
    class Dummy { }
    static let test = Bundle(for: Dummy.self)
}
