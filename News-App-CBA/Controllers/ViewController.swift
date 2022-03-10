//
//  ViewController.swift
//  News-App-CBA
//
//  Created by Nalin Aswani on 9/03/22.
//

import UIKit

class ViewController: UIViewController {

    let parser = ParserViewModelProtocol()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .red
    }
    
    func getJsonObjects() -> ApiRoot {
        let json:String = parser.parseNewsApi() // The get request returns a string
        // print(json)
        let jsonData = Data(json.utf8) // we format this string into utf8, and change type to data
        
        // We then use the data above to decode the data into a json object below.
        // Here I use try! This is to ensure that if the parsing fails it will crash my program.
        // TODO: Perhaps rather than crashing the whole app due to an api, we provide a fail safe.
        
        let myDecoder = JSONDecoder()
        myDecoder.dateDecodingStrategy = .iso8601 // Using a different date decoding stratagy to decode the specific type of date given from this api
        
        let articleObjects = try! myDecoder.decode(ApiRoot.self, from: jsonData)
        print(type(of: articleObjects))
        print(articleObjects.status)
        print(articleObjects.totalResults)
        
        return articleObjects
    }


}

