//
//  CountryListTests.swift
//  CurrencyConverterTests
//
//  Created by Gokhan Gultekin on 20.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class CountryListTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testParseCountryList() {
        
        do {
            try MockResourceLoader.loadCountries(success: { (response) in
                
                if let country = response.countries.first {
                    XCTAssertEqual(country.cc, "AED")
                    XCTAssertEqual(country.name, "UAE dirham")
                } else {
                    XCTAssert(false)
                }
                
            }) { (error) in
                XCTAssert(false)
            }
            
        } catch {
            XCTAssert(false)
        }
    }
}

final class MockResourceLoader: ResourceLoaderProtocol {
    static func loadCountries(success: @escaping (CountriesResponse) -> Void, failure: @escaping (RLError) -> Void) throws { }
}
