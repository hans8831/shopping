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
        
        let bag = ProductBag(currency: .USD)
        
        XCTAssertEqual(bag.count, 0)
        
        let product = Product(id: "_id_product", name: "product", unit: Unit(string: "unit"), unitPrice: Price(amount: NSDecimalNumber(double: 0), currency: .USD), info: "Product info text")

        // add product
        bag.addProduct(product)
        XCTAssert(bag.count == 1)
        XCTAssertEqual(bag.countForProduct(product), 1)
        
        // remove product
        bag.removeProduct(product)
        XCTAssertEqual(bag.count, 0)

        // try to remove product again
        bag.removeProduct(product)
        XCTAssertEqual(bag.count, 0)
    }
    
    func testShopping() {
        let bag = ProductBag(currency: .USD)
        let products = Shop.products
        
        // find milk product
        let milks = products.filter {
            $0.name == "milk"
        }
        
        XCTAssertNotNil(milks)
        XCTAssertEqual(milks.count, 1)
        
        // add 3 milk
        let milk = milks[0]
        bag.addProduct(milk)
        bag.addProduct(milk)
        bag.addProduct(milk)
        
        XCTAssertEqual(bag.countForProduct(milk), 3)
        XCTAssertEqual(bag.totalPrice.amount, 3.9)
        
        // find eggs product
        let eggsArray = products.filter {
            $0.name == "eggs"
        }
        
        XCTAssertNotNil(eggsArray)
        XCTAssertEqual(eggsArray.count, 1)
        
        let eggs = eggsArray[0]

        // add 2 dozen of eggs
        bag.addProduct(eggs)
        bag.addProduct(eggs)
        
        XCTAssertEqual(bag.countForProduct(eggs), 2)
        XCTAssertEqual(bag.totalPrice.amount, 8.1)

        // remove 1 milk
        bag.removeProduct(milk)
        
        XCTAssertEqual(bag.countForProduct(milk), 2)
        XCTAssertEqual(bag.totalPrice.amount, 6.8)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
