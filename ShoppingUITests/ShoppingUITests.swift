//
//  ShoppingUITests.swift
//  ShoppingUITests
//
//  Created by Roland Michelberger on 10/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

import XCTest

class ShoppingUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShopping() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        
        // open milk
        app.tables.cells.elementBoundByIndex(2).tap()
        
        XCTAssert(app.staticTexts["0"].exists)
        
        // add milk
        let button = app.buttons["+"]
        button.tap()
        
        XCTAssert(app.staticTexts["1"].exists)
        
        // navigate back
        app.navigationBars["milk"].buttons["Products"].tap()
        
        // open eggs
        app.tables.cells.elementBoundByIndex(1).tap()
        
        XCTAssert(app.staticTexts["0"].exists)
        
        // add eggs
        button.tap()
        button.tap()
        
        // there should be 2 eggs
        XCTAssert(app.staticTexts["2"].exists)
        
        // navigate back
        app.navigationBars["eggs"].buttons["Products"].tap()
        
        // open milk
        app.tables.cells.elementBoundByIndex(2).tap()
        
        XCTAssert(app.staticTexts["1"].exists)
        
        // remove milk
        app.buttons["-"].tap()
        
        XCTAssert(app.staticTexts["0"].exists)
        
        // navigate back
        app.navigationBars["milk"].buttons["Products"].tap()
        
        // open basket
        app.navigationBars["Products"].buttons["basketIcon"].tap()
        
        // total price
        XCTAssert(app.staticTexts["total: USD 4.2"].exists)
        
        // navigate back
        app.navigationBars["Basket"].buttons["Products"].tap()
        
    }
    
}
