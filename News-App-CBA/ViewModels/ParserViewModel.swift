//
//  Parser.swift
//  News-App-CBA
//
//  Created by Nalin Aswani on 10/03/22.
//

import Foundation

struct ParserViewModel: ParserViewModelProtocol {
    func getArticleObjects(searchQuery: String? = nil) -> [Article] {
        var json : String = ""
        
        // This section below sees if we are doing UI testing, if so, we mock a json response rather than calling the api
        let uiTesting = ProcessInfo.processInfo.arguments.contains("Testing")
        if uiTesting {
            json = mock_good_response
        } else { // If we are not doing UI testing, we will use the api get request
            if searchQuery != nil {
                json = parseNewsApi(searchQuery: searchQuery) // if we have a searchquery then find articles with that
            } else {
                json = parseNewsApi() // otherwise just do it the default way, top results for australia
            }
        }
        
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
    
    func parseNewsApi(searchQuery: String? = nil) -> String {
        let apiKey = Bundle.main.infoDictionary?["API_KEY"]
        
        // The default news shown is the top headlines for australia
        var urlString = "https://newsapi.org/v2/top-headlines?country=au&apiKey=\(String(describing: apiKey!))"
        
        if searchQuery != nil { // Otherwise if the user searches, they can see curated news
            urlString = "https://newsapi.org/v2/everything?q=\(String(describing: searchQuery!))&apiKey=\(String(describing: apiKey!))"
        }
        
        guard let myURL = URL(string: urlString) else {
            print("Error: \(String(describing: link)) invalid url: \(urlString)")
            return "" // TODO: Do error handling for api failures
        }
        do {
            let content = try String(contentsOf: myURL, encoding: .ascii)
            return content // Here we return the contents of the api get request as a large string.
        } catch let error {
            print("Error: \(error)")
        }
        return ""  // TODO: Do error handling for api failures
        // There are two status', there is ok, and there is error.
    }
}
