//
//  CurrencyConverterTests.swift
//  CurrencyConverterTests
//
//  Created by Gokhan Gultekin on 13.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class CurrencyConverterTests: XCTestCase {

    private var view: MockView!

    override func setUp() {
        view = MockView()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCheck() {
        
        XCTAssertTrue(view.check(string: "12,4"))
        XCTAssertFalse(view.check(string: "12,,4"))
        XCTAssertFalse(view.check(string: "12,4,"))
        XCTAssertTrue(view.check(string: "12,4222"))
        XCTAssertFalse(view.check(string: "12,42222"))
        XCTAssertTrue(view.check(string: "12.4"))
        XCTAssertFalse(view.check(string: ","))
        XCTAssertFalse(view.check(string: ",,"))
        XCTAssertFalse(view.check(string: ",2"))
    }
}


class MockView: ConverterViewModelDelegate {

    func handleViewModelOutput(_ output: ConverterViewModelOutput) { }

    func navigate(to route: ConverterViewRoute) { }

    func check(string: String) -> Bool {
        
        var text = string
        
        let numberOfDots = text.components(separatedBy: ",").count - 1
        
        let numberOfDecimalDigits: Int
        if let dotIndex = text.index(of: ",") {
            numberOfDecimalDigits = text.distance(from: dotIndex, to: text.endIndex) - 1
        } else {
            numberOfDecimalDigits = 0
        }
        
        if numberOfDots <= 1 && numberOfDecimalDigits <= 4 {
            
            text = text.replacingOccurrences(of: ",", with: ".")
            
            if text.count > 0 {
                if text.first == "." { return false }
            }
            return true
        } else { return false }
    }
}

