//
//  ViewController.swift
//  News-App-CBA
//
//  Created by Nalin Aswani on 9/03/22.
//

import UIKit

class ListViewController: UIViewController {
    let tableView = UITableView()
    
    let parser = ParserViewModelProtocol()
    var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Nalin's News "
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds 
    }
    
    ///Initialises the tableview
    func setupTableView() {
        view.addSubview(tableView)
        tableView.register(ListViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        
    }
    
    override func viewWillAppear(_ animated: Bool) {  // reloads the table when the view appears
        reloadTableViewData()
    }
    
    func reloadTableViewData() {
        articles = parser.getArticleObjects() // Here I am loading the table data (array of articles)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ListViewCell
        let article = articles[indexPath.row] // Gets the article by looking at the number of the row
        cell.set(article: article)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // This deselects a row after it is tapped on by a user
        
//        let article = articles[indexPath.row]
//        if let url = URL(string: article.url) { // When you tap on a row, it goes to the news link
//            UIApplication.shared.open(url)
//        }
    }
}

