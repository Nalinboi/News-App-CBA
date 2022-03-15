//
//  News_App_CBAUITests.swift
//  News-App-CBAUITests
//
//  Created by Nalin Aswani on 9/03/22.
//

import XCTest

@testable import News_App_CBA

class News_App_CBAUITests: XCTestCase {
    var app = XCUIApplication()
    
    override func setUpWithError() throws {
        app.launchArguments.append("Testing")
        app.launch()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTableAppears() throws {
        let table = app.tables.firstMatch
        XCTAssert(table.exists) // Ensuring that something on table appears
    }
    
    func testTitleAppears() throws {
        XCTAssert(app.staticTexts["Nalin's News"].exists)
    }
    
    func testRowAppears() throws {
        XCTAssert(app.staticTexts["Fourth Japanese encephalitis case detected in NSW - The West Australian"].exists)
    }

    // would add more tests using app.tables.staticTexts

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                app = XCUIApplication()
                app.launchArguments.append("Testing")
                app.launch()
            }
        }
    }
}
