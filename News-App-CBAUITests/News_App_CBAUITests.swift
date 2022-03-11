//
//  News_App_CBAUITests.swift
//  News-App-CBAUITests
//
//  Created by Nalin Aswani on 9/03/22.
//

import XCTest

@testable import News_App_CBA

class News_App_CBAUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTableAppears() throws {
        let app = XCUIApplication()
        app.launch()
        
        let table = app.tables.firstMatch
        XCTAssert(table.exists) // Ensuring that something on table appears
    }

    // would add more tests using app.tables.staticTexts

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
