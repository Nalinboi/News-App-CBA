//
//  Parser.swift
//  News-App-CBA
//
//  Created by Nalin Aswani on 10/03/22.
//

import Foundation

struct ParserViewModelProtocol {
    func parseNewsApi() -> String {
        let apiKey = Bundle.main.infoDictionary?["API_KEY"]
        let urlString = "https://newsapi.org/v2/top-headlines?country=au&apiKey=\(String(describing: apiKey!))"
        
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
    
    func getArticleObjects() -> [Article] {
        let json:String = parseNewsApi() // The get request returns a string
        let jsonData = Data(json.utf8) // we format this string into utf8, and change type to data
        
        // We then use the data above to decode the data into a json object below.
        // Here I use try! This is to ensure that if the parsing fails it will crash my program.
        // TODO: Perhaps rather than crashing the whole app due to an api, we provide a fail safe.
        
        let myDecoder = JSONDecoder()
        myDecoder.dateDecodingStrategy = .iso8601 // Using a different date decoding stratagy to decode the specific type of date given from this api
        
        let articleObjects = try! myDecoder.decode(ApiRoot.self, from: jsonData)
        
        return articleObjects.articles
    }
}
