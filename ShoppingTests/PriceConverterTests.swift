//
//  PriceConverterTests.swift
//  Shopping
//
//  Created by Roland Michelberger on 10/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

import XCTest

class PriceConverterTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPriceConverterWithMockServer() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let expectation = expectationWithDescription("The completion should be called.")

        let price = Price(amount: NSDecimalNumber(double: 1.0), currency: .USD)
        
        PriceConverter.pricesForPrice(price) { (prices, error) -> Void in

            // there should be no error
            XCTAssertNil(error)
            // there should be data
            XCTAssertNotNil(prices)
            
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(3, handler: nil)

    }
    
    func testPrices(prices: [Price]) {
        
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
