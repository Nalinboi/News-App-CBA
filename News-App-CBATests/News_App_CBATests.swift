//
//  News_App_CBATests.swift
//  News-App-CBATests
//
//  Created by Nalin Aswani on 9/03/22.
//

import XCTest
@testable import News_App_CBA

class News_App_CBATests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    // This is to test that the api works fine and returns articles
    func testGoodJson() throws {
        let mockParserClient = MockParserViewModel()
        let articleObjects:[Article] = mockParserClient.getArticleObjects()
        
        XCTAssertEqual(articleObjects.count, 1)
    }
    
    // This is to test that when something goes wrong with the api, rather than crashing, it will return 0 article objects.
    // The error should be logged for developers to notice. 
    func testBadJson() throws {
        let mockParserClient = MockParserViewModel(true)
        let articleObjects:[Article] = mockParserClient.getArticleObjects()
        
        XCTAssertEqual(articleObjects.count, 0)
    }

}
