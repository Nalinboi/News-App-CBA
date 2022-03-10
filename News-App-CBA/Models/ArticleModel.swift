//
//  Article.swift
//  News-App-CBA
//
//  Created by Nalin Aswani on 10/03/22.
//

import Foundation

//https://newscatcherapi.com/free-news-api

struct ApiRoot : Codable {
    let status : String // Must have a status
    let totalResults : Int // Must have results
    let articles : [Article] // Must have articles
}

struct Article : Codable {
    let source : Source // Must have source
    let author : String?
    let title : String // Must have title
    let description : String?
    let url : String // Must have url
    let urlToImage :String?
    let publishedAt : Date // Must have a date published at
    let content : String?
}

struct Source : Codable {
    let id : String?
    let name : String // Must have source name
}
