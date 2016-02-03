//
//  MovingHelperUITests.swift
//  MovingHelperUITests
//
//  Created by mkon on 2/3/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import XCTest

class MovingHelperUITests: XCTestCase {
        
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
    
    func testExample() {
        
        
        let app = XCUIApplication()
        app.buttons["Create Tasks"].tap()
        
        let tablesQuery = app.tables
        tablesQuery.cells.containingType(.StaticText, identifier:"Set up utilities at new place").childrenMatchingType(.Button).element.tap()
        tablesQuery.cells.containingType(.StaticText, identifier:"Hire Movers").childrenMatchingType(.Button).element.tap()
        
    }
    
}
