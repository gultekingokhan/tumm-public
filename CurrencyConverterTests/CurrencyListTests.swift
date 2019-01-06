//
//  CurrencyListTests.swift
//  CurrencyConverterTests
//
//  Created by Gokhan Gultekin on 6.01.2019.
//  Copyright © 2019 Gokhan Gultekin. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class CurrencyListTests: XCTestCase {

    private var view: MockCurrencyListView!
    private var viewModel: CurrencyListViewModel!
    private var service: MockRatesService!
    
    override func setUp() {
        service = MockRatesService()
        view = MockCurrencyListView()
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
    
    func testLoadIfSell() {
        //Given
        viewModel = CurrencyListViewModel(service: service, rateType: .SELL, isUpdating: false)
        viewModel.delegate = view

        service.ratesFromService = ["USD": 12.0, "EUR": 13.0]
        //When
        viewModel.load()
        //Then
        XCTAssertEqual(view.outputs.count, 4)
        
        switch view.outputs[0] {
        case .updateTitle(_):
            break // Success!
        case .showLatestRates(let presentation):
            let expectedPresentation = CurrencyListPresentation(base: "USD", date: "", rates: ["USD": 12.0, "EUR": 13.0])
            XCTAssertEqual(presentation.rates, expectedPresentation.rates)
            break // Success!

        default:
            XCTFail("First output should be `updateTitle`.")
        }
      
        XCTAssertEqual(view.outputs[1], .showLoading(true))
        XCTAssertEqual(view.outputs[2], .showLoading(false))
        
        switch view.outputs[3] {
        case .showLatestRates(let presentation):
            let expectedPresentation = CurrencyListPresentation(base: "USD", date: "", rates: ["USD": 12.0, "EUR": 13.0])
            XCTAssertEqual(presentation.rates.count, expectedPresentation.rates.count)
        break // Success!
        default:
            XCTFail("Third output should be `.showLatestRates`.")
        }
    }
}

class MockCurrencyListView: CurrencyListViewModelDelegate {
    
    var outputs: [CurrencyListViewModelOutput] = []
    
    func handleViewModelOutput(_ output: CurrencyListViewModelOutput) {
        outputs.append(output)
    }
    
    func navigate(to route: ConverterViewRoute) {
        
    }
}
