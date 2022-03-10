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
}
