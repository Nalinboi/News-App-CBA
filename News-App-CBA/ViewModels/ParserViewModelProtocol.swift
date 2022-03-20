//
//  ParserViewModelProtocol.swift
//  News-App-CBA
//
//  Created by Nalin Aswani on 11/03/22.
//

import Foundation

protocol ParserViewModelProtocol {
    // functions with the the optional search parameter
    func parseNewsApi(searchQuery: String?) -> String
    func getArticleObjects(searchQuery: String?) -> [Article]
}

extension ParserViewModelProtocol {
    //functions without the optional parameters (work-around for no way to have default values in protocols)
    func parseNewsApi() {
        parseNewsApi(searchQuery: nil)
    }
    func getArticleObjects() {
        getArticleObjects(searchQuery: nil)
    }
}
