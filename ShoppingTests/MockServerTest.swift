//
//  MockServerTest.swift
//  Shopping
//
//  Created by Roland Michelberger on 11/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

import XCTest

class MockServerTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMockServerExchangeRatesForUSD() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let expectation = expectationWithDescription("The completion should be called.")
        
        MockServer.exchangeRatesDataForUSD { (data, error) -> Void in
            // there should be no error
            XCTAssertNil(error)
            // there should be data
            XCTAssertNotNil(data)
            
            
            let result = JSONParser.exchangeRatesFromJSONRateResponseData(data!)
            
            // there should be no error
            XCTAssertNil(result.error)
            // there should be data
            XCTAssertNotNil(result.exchangeRates)
            
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(3, handler: nil)
    }
    
    
    func testMockServerExchangeRatesDataForUSD() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let expectation = expectationWithDescription("The completion should be called.")
        
        MockServer.exchangeRatesDataForUSD { (data, error) -> Void in
            // there should be no error
            XCTAssertNil(error)
            // there should be data
            XCTAssertNotNil(data)
            
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(2, handler: nil)
    }
    
    func testMockServerExchangeRateData() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let expectation = expectationWithDescription("The completion should be called.")
        
        MockServer.exchangeRateData(Currency.EUR, to: Currency.CHF) { (data, error) -> Void in
            // there should be no error
            XCTAssertNil(error)
            // there should be data
            XCTAssertNotNil(data)
            
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(2, handler: nil)
    }
    
    func testMockServerExchangeRate() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let expectation = expectationWithDescription("The completion should be called.")
        
        let fromCurrency = Currency.EUR
        let toCurrency = Currency.CHF
        MockServer.exchangeRateData(fromCurrency, to: toCurrency) { (data, error) -> Void in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            
            // data should be JSON string
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                
                if let dict = json as? [String: AnyObject] {
                    
                    if let exchangeRate = ExchangeRate(dict: dict) {
                        
                        XCTAssertEqual(exchangeRate.from, fromCurrency)
                        XCTAssertEqual(exchangeRate.to, toCurrency)
                        XCTAssert(0.5 <= exchangeRate.rate && exchangeRate.rate <= 1.5)
                        
                    } else {
                        XCTAssert(false, "\(dict) can not be converted to ExchangeRate")
                    }
                    
                } else {
                    XCTAssert(false, "\(json) is not [String: AnyObject]")
                }
                
            } catch {
                XCTAssertNil(error)
            }
            
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(2, handler: nil)
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
