//
//  CountriesResponse.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 20.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import Foundation

public struct CountriesResponse: Decodable {
    
    public let countries: [Country]
    
    init(countries: [Country]) {
        self.countries = countries
    }
    
    private enum RootCodingKeys: String, CodingKey {
        case countries
    }
    
    public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        self.countries = try rootContainer.decode([Country].self, forKey: .countries)
    }
}
