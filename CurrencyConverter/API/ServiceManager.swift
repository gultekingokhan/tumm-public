//
//  ServiceManager.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 13.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import Foundation
import Alamofire

enum Endpoint: String {
    case latest
}

protocol ServiceManagerProtocol {
    
    static func get(from url: URL, params: [String:String]?, completion: @escaping (DataResponse<Data>) -> Void)
    
}

struct ServiceManager: ServiceManagerProtocol {
    
    static func get(from url: URL, params: [String:String]?, completion: @escaping (DataResponse<Data>) -> Void) {
        
        request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: Credentials.API.headers).responseData { (response) in
            completion(response)
        }
    }
    
    static func makeURL(with endpoint: Endpoint) -> URL {
        let urlString = Credentials.API.base_url + endpoint.rawValue
        return URL(string: urlString)!
    }
}
