//
//  data.swift
//  News-App-CBA
//
//  Created by Nalin Aswani on 16/03/22.
//

import Foundation

// Data file that contains different mock json data responses.

let mock_good_response = """
    {"status":"ok","totalResults":38,"articles":[{"source":{"id":null,"name":"The West Australian"},"author":"NCA NewsWire","title":"Fourth Japanese encephalitis case detected in NSW - The West Australian","description":"A deadly disease spread by mosquitoes that’s never been detected in NSW before has now infected more people, it’s been revealed.","url":"https://thewest.com.au/lifestyle/fourth-japanese-encephalitis-case-detected-in-nsw-c-6004863","urlToImage":"https://images.thewest.com.au/publication/C-6004863/aad89e97f23bffe873259238d8f53cf015ab1091-16x9-x0y0w2047h1151.jpg?imwidth=1200","publishedAt":"2022-03-10T04:29:00Z","content":"NSW has recorded its fourth case of Japanese encephalitis as the disease spreads across the state.The mosquito-borne virus had never been detected in the state before this year.The latest person … [+1426 chars]"}]}
    """

let mock_bad_response = """
    {"status": "error", "code": "apiKeyMissing", "message": "Your API key is missing. Append this to the URL with the apiKey param, or use the x-api-key HTTP header."}
    """


