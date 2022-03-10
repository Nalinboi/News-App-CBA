//
//  ViewController.swift
//  News-App-CBA
//
//  Created by Nalin Aswani on 9/03/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView()
    
    let parser = ParserViewModelProtocol()
    var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        view.backgroundColor = .red
        title = "Hello"
        articles = parser.getArticleObjects()
        
        setupTableView()
    }
    
    ///Initialises the tableview
    func setupTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let article = articles[indexPath.row] // Gets the invoice by looking at the number of the row
        let title = article.title
        
        cell.textLabel?.text = "\(title)" // Here we are simply naming each cell item in the table by their invoice number
        return cell
    }
    
}

