//
//  MockParserViewModel.swift
//  News-App-CBATests
//
//  Created by Nalin Aswani on 11/03/22.
//

import Foundation
@testable import News_App_CBA

class MockParserViewModel {
    var shouldReturnError = false
    var parseWasCalled = false
    
    func reset() {
        shouldReturnError = false
        parseWasCalled = false
    }
    
    convenience init() { // if you call the mock parser it will automatically expect no error
        self.init(false )
    }
    
    init(_ shouldReturnError: Bool) { // unless you specify it to have an error. 
        self.shouldReturnError = shouldReturnError
    }
}

// This logic conforms under the parserviewmodelprotocol so we can mock the api feedback as well
extension MockParserViewModel: ParserViewModelProtocol {
    func parseNewsApi() -> String {
        if shouldReturnError { // If it is noted that the api request should return an error, then we use the bad json above
            return mock_bad_response
        } else {
            return mock_good_response
        }
    }
    
    func getArticleObjects() -> [Article] {
        let json:String = parseNewsApi() // The get request returns a string
        let jsonData = Data(json.utf8) // we format this string into utf8, and change type to data
        
        // We then use the data above to decode the data into a json object below.
        // Here I use try! This is to ensure that if the parsing fails it will crash my program.
        // TODO: Perhaps rather than crashing the whole app due to an api, we provide a fail safe.
        
        let myDecoder = JSONDecoder()
        myDecoder.dateDecodingStrategy = .iso8601 // Using a different date decoding stratagy to decode the specific type of date given from this api
        
        let articleObjects = try! myDecoder.decode(ApiRoot.self, from: jsonData)
        
        if articleObjects.status == "ok" { // status can only be ok or error
            if articleObjects.articles != nil {
                return articleObjects.articles!
            }
        }
        
        // we do not want to crash the program, if nothing returns then so be it. 
        return [] // TODO: error handling: if all else fails return nothing
    }
}
