//
//  ShoppingTests.swift
//  ShoppingTests
//
//  Created by Roland Michelberger on 10/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

import XCTest
@testable import Shopping

class ShoppingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBag() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let bag = Bag()
        
        XCTAssert(bag.count == 0)
        
        let product = Product(name: "product", unitName: "unit", unitPrice: Price(amount: NSDecimalNumber(double: 0), currency: Currency.USD))
        
        bag.addProduct(product)
        
        XCTAssert(bag.count == 1)
        XCTAssert(bag.countForProduct(product) == 1)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
