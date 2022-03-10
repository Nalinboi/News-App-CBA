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
        parser.getArticleObjects()
    }
}

