//
//  ArticleWebViewController.swift
//  News-App-CBA
//
//  Created by Nalin Aswani on 21/03/22.
//

import UIKit
import WebKit

class ArticleWebViewController: UIViewController {
    let webView = WKWebView()
    private let article: Article
    
    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = article.title
        
        view.addSubview(webView)
        
        guard let url = URL(string: article.url) else {
            return
        }
        webView.load(URLRequest(url: url))
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
        
    }
    


}
