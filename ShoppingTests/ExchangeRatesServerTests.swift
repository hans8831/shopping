//
//  ExchangeRatesServerTests.swift
//  Shopping
//
//  Created by Roland Michelberger on 11/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

import XCTest

class ExchangeRatesServerTests: XCTestCase {
    
    let timeOut = 20.0
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testServer() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let expectation = expectationWithDescription("The completion should be called.")
        
        let currency = Currency.EUR
        ExchangeRatesServer.exchangeRatesData(currency) { (data, error) -> Void in
            // there should be no error
            XCTAssertNil(error)
            // there should be data
            XCTAssertNotNil(data)
            
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(timeOut, handler: nil)
    }
    
    func testServerExchangeRates() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let expectation = expectationWithDescription("The completion should be called.")
        
//        let currency = Currency.EUR
        let currency = Currency.USD
      
        ExchangeRatesServer.exchangeRatesData(currency) { (data, error) -> Void in
            
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            
            let result = JSONParser.exchangeRatesFromJSONRateResponseData(data!)
            
            if currency == .USD {
                // there should be no error
                XCTAssertNil(result.error)
                
                // there should be the exchange rates
                XCTAssertNotNil(result.exchangeRates)
                
                if let exchangeRates = result.exchangeRates {
                    
                    // source currency should be equal
                    XCTAssertEqual(exchangeRates.source, currency)
                    
                    for exchangeRate in exchangeRates.quotes {
                        XCTAssert(exchangeRate.rate >= 0)
                    }
                    
                } else {
                    XCTAssert(false, "JSON is not [String: AnyObject]")
                }
            }
                // the free plan only supports USD
                // all other currency will fail
            else {
                // there should be a parsing error
                XCTAssertNotNil(result.error)
            }
            
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(timeOut, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
