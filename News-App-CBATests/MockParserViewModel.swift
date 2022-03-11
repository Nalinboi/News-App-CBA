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
    
    let good_data = """
        {"status":"ok","totalResults":38,"articles":[{"source":{"id":null,"name":"The West Australian"},"author":"NCA NewsWire","title":"Fourth Japanese encephalitis case detected in NSW - The West Australian","description":"A deadly disease spread by mosquitoes that’s never been detected in NSW before has now infected more people, it’s been revealed.","url":"https://thewest.com.au/lifestyle/fourth-japanese-encephalitis-case-detected-in-nsw-c-6004863","urlToImage":"https://images.thewest.com.au/publication/C-6004863/aad89e97f23bffe873259238d8f53cf015ab1091-16x9-x0y0w2047h1151.jpg?imwidth=1200","publishedAt":"2022-03-10T04:29:00Z","content":"NSW has recorded its fourth case of Japanese encephalitis as the disease spreads across the state.The mosquito-borne virus had never been detected in the state before this year.The latest person … [+1426 chars]"}]}
        """
    
    let bad_data = """
        {"status": "error", "code": "apiKeyMissing", "message": "Your API key is missing. Append this to the URL with the apiKey param, or use the x-api-key HTTP header."}
        """
}

// This logic conforms under the parserviewmodelprotocol so we can mock the api feedback as well
extension MockParserViewModel: ParserViewModelProtocol {
    func parseNewsApi() -> String {
        if shouldReturnError { // If it is noted that the api request should return an error, then we use the bad json above
            return bad_data
        } else {
            return good_data
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
