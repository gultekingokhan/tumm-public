//
//  CurrencyConverterTests.swift
//  CurrencyConverterTests
//
//  Created by Gokhan Gultekin on 13.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import XCTest
import CoreData
@testable import CurrencyConverter

class CurrencyConverterTests: XCTestCase {

    private var view: MockView!
    private var viewModel: ConverterViewModel!
    private var service: MockRatesService!
    
    override func setUp() {
        service = MockRatesService()
        viewModel = ConverterViewModel(service: service)
        view = MockView()
        viewModel.delegate = view
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
    
    func testLoad() {
        //Given
        let rate1 = Rate(id: "0", value: 12.0, code: "USD", type: .BUY, name: "United State Dollars")
        let rate2 = Rate(id: "1", value: 13.0, code: "EUR", type: .SELL, name: "Euro")

        service.ratesFromService = ["USD": 12.0, "EUR": 13.0]
        service.rates = [rate1, rate2]
        //When
        viewModel.load()
        //Then
        XCTAssertEqual(view.outputs.count, 4)
        
        switch view.outputs[0] {
        case .updateTitle(_):
            break // Success!
        default:
            XCTFail("First output should be `updateTitle`.")
        }
        
        XCTAssertEqual(view.outputs[1], .showLoading(true))
        XCTAssertEqual(view.outputs[2], .showLoading(false))
        
        switch view.outputs[3] {
        case .showConverterRates(let presentation):
            let expectedPresentation = ConverterRatesPresentation(rates: [rate1, rate2])
            XCTAssertEqual(presentation.rates, expectedPresentation.rates)
        break // Success!
        default:
            XCTFail("First output should be `updateTitle`.")
        }
    }
    
    func testUpdateSavedCurrencies() {
        
        //Given
        let rate1 = Rate(id: "0", value: 12.0, code: "USD", type: .BUY, name: "United State Dollars")
        let rate2 = Rate(id: "1", value: 13.0, code: "EUR", type: .SELL, name: "Euro")
        
        service.ratesFromService = ["USD": 12.0, "EUR": 13.0]
        service.rates = [rate1, rate2]
        viewModel.load()
        
        //When
        let rate = Rate(id: "1", value: 13.0, code: "EUR", type: .SELL, name: "Euro")
        viewModel.updateSavedCurrencies(with: .SELL, isUpdating: true, selectedRate: rate)

        //Then
        XCTAssertTrue(view.currencyListRouteCalled)
    }
}

class MockView: ConverterViewModelDelegate {

    var outputs: [ConverterViewModelOutput] = []
    var currencyListRouteCalled = false

    func handleViewModelOutput(_ output: ConverterViewModelOutput) {
        outputs.append(output)
    }

    func navigate(to route: ConverterViewRoute) {
        
        switch route {
        case .currencyList(_):
            currencyListRouteCalled = true
            break
        default:
            break
        }
    }

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

class MockRatesService: RatesServiceProtocol {
    
    var ratesFromService: [String: Double] = [:]
    var rates: [Rate] = []
    
    func fetchLatestRates(base: String, completion: @escaping (Result<LatestRatesResponse>) -> Void) {
        completion(.success(LatestRatesResponse(date: "", base: "", rates: ratesFromService)))
    }

    func fetchSavedRates(completion: @escaping (ConverterRatesResponse) -> Void) {
        completion(ConverterRatesResponse(rates: rates))
    }
}
