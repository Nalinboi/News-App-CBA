//
//  ViewController.swift
//  News-App-CBA
//
//  Created by Nalin Aswani on 9/03/22.
//

import UIKit

class ListViewController: UIViewController {
    let tableView = UITableView()
    let searchController = UISearchController()
    
    let parser = ParserViewModel()
    var articles: [Article] = []
    
    let articlesPerPagination: Int = 3 // How many more articles to load after paginating (constant)
    let articlesBeforePagination: Int = 10 // How many articles we load before table is paginated.
    
    var paginations: Int = 0
    var isPaginating: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Nalin's News"
        
        setupRefreshControl()
        setupSearchBar()
        setupTableView()
    }
    
    /// Happens when the user pulls down to refresh
    @objc private func pullDownRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.reloadTableViewData()
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    /// Happens when the user pulls up to load more articles.
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
        tableView.rowHeight = 400
        
        tableView.pin(to: view)
    }
    
    /// Setting up the search bar
    func setupSearchBar() {
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    /// Setting up for the loading circle for refreshing/pulling down
    func setupRefreshControl(){
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(pullDownRefresh), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {  // reloads the table when the view appears
        reloadTableViewData()
    }
    
    /// A function that can be called to load new data (either when refreshing or typing a new request)
    func reloadTableViewData(searchQuery: String? = nil) {
        paginations = 0 // Everytime we refresh the page, we will reset paginations to 0
        if searchQuery != nil {
            articles = parser.getArticleObjects(searchQuery: searchQuery) // Loading articles that include the searchquery
        } else {
            articles = parser.getArticleObjects() // Loading top headlines right now (in australia)
        }
        self.tableView.reloadData()
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UISearchBarDelegate {
    // MARK: UISearchBarDelegate
    /// Updates everytime user presses search after typing something in the search bar.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else { // Safely unwrap text in search bar, otherwise return
            return
        }
        reloadTableViewData(searchQuery: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        reloadTableViewData() // If the cancel button was pressed then we reload the table with the top headlines (no curated)
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return whatever is less, either the articles according to paginations, or the max number of articles.
        return min(articlesToShow, articles.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ListViewCell
        let article = articles[indexPath.row] // Gets the article by looking at the number of the row
        cell.set(article: article)
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // This deselects a row after it is tapped on by a user
        
        let article = articles[indexPath.row]
        let webView = ArticleWebViewController(article: article)
        navigationController?.pushViewController(webView, animated: true) // Pushing navigation to the webview of the article
        
        // if let url = URL(string: article.url) { // When you tap on a row, it goes to the news link
        //     UIApplication.shared.open(url)
        // }
    }
    
    
    // MARK: UIScrollViewDelegate
    // A function that gets triggered when you scroll to the bottom for pagination. 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let positionY = scrollView.contentOffset.y
        if positionY > tableView.contentSize.height-80-scrollView.frame.size.height {
            guard !isPaginating else {
                return
            }
            if isEnd { return } // If we have reached the end of content, no more paginating.
            
            self.isPaginating = true
            self.tableView.tableFooterView = pullUpLoad()
            
            // if it is paginating wait for 1 second and load more data
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.paginations += 1
                self.tableView.reloadData()
                self.tableView.tableFooterView = nil
                self.isPaginating = false
            }
        }
    }
    
    // MARK: Helpers
    // Computed value to see how many articles we should show based on paginations (how much they have scrolled)
    var articlesToShow: Int {
        (articlesBeforePagination + (paginations * articlesPerPagination))
    }
    
    var isEnd: Bool { // Computed value to see if the user has scrolled to the end.
        articlesToShow >= articles.count
    }
}

