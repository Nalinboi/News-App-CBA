//
//  ViewController.swift
//  News-App-CBA
//
//  Created by Nalin Aswani on 9/03/22.
//

import UIKit

class ListViewController: UIViewController {
    let tableView = UITableView()
    
    let parser = ParserViewModel()
    var articles: [Article] = []
    
    var isPaginating: Bool = false
    var paginations: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(pullDownRefresh), for: .valueChanged)
        
        title = "Nalin's News "
        setupTableView()
    }
    
    @objc private func pullDownRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.reloadTableViewData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    private func pullUpLoad() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
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
        
        tableView.pin(to: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {  // reloads the table when the view appears
        reloadTableViewData()
    }
    
    func reloadTableViewData() {
        paginations = 0 // Everytime we refresh the page, we will reset paginations to 0
        articles = parser.getArticleObjects() // Here I am loading the table data (array of articles)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
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
        
        let article = articles[indexPath.row]
        if let url = URL(string: article.url) { // When you tap on a row, it goes to the news link
            UIApplication.shared.open(url)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let positionY = scrollView.contentOffset.y
        if positionY > tableView.contentSize.height-80-scrollView.frame.size.height {
            if !isPaginating {
                isPaginating = true
                // print("fetch more data")
                self.tableView.tableFooterView = pullUpLoad()
            } else { // if it is paginating wait for 1 second and load more data
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.paginations += 1
                    self.tableView.tableFooterView = nil
                    self.isPaginating = false
                }
            }
        }
    }
}

