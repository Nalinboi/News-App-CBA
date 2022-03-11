//
//  ParserViewModelProtocol.swift
//  News-App-CBA
//
//  Created by Nalin Aswani on 11/03/22.
//

import Foundation

protocol ParserViewModelProtocol {
    func parseNewsApi() -> String
    func getArticleObjects() -> [Article]
}
