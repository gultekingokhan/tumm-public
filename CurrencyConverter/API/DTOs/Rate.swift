//
//  Rate.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 25.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import Foundation

public enum RateType: String {
    case SELL
    case BUY
    case None
}

extension RateType: Codable {
    public init(from decoder: Decoder) throws {
        self = try RateType(rawValue: decoder.singleValueContainer().decode(String.self)) ?? .None
    }
}

final class Rate: NSObject {
    
    var id: String?
    var code: String
    var type: RateType
    var name: String
    var value: Double?
    var isAdded: Bool?

    init(id: String? = nil, value: Double? = 0.0, code: String, type: RateType, name: String) {
        self.id = id
        self.value = value
        self.code = code
        self.type = type
        self.name = name
        self.isAdded = false
    }
}


