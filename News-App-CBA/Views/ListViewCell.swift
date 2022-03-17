//
//  ListViewCell.swift
//  News-App-CBA
//
//  Created by Nalin Aswani on 11/03/22.
//

import UIKit

class ListViewCell: UITableViewCell {
    
    var thumbnail = UIImageView()
    var title = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(thumbnail)
        addSubview(title)
        
        configureThumbnail()
        configureTitle()
        
        setThumbnailConstraints()
        setTitleConstraints()
    }
    
    func set(article: Article) {
        if let url = article.urlToImage { // When you tap on a row, it goes to the news link
            thumbnail.load(url: URL(string: url)!)
        }
        
        title.text = article.title
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        // We do this to avoid a bug where reused cells display wrong images
        self.thumbnail.image = nil
    }
    
    func configureThumbnail() {
        thumbnail.layer.cornerRadius = 10
        thumbnail.clipsToBounds = true
    }
    
    func configureTitle() {
        title.numberOfLines = 0
        title.adjustsFontSizeToFitWidth = true
        
    }
    
    func setThumbnailConstraints() {
        thumbnail.translatesAutoresizingMaskIntoConstraints = false
        thumbnail.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        thumbnail.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        thumbnail.heightAnchor.constraint(equalToConstant: 80).isActive = true
        thumbnail.widthAnchor.constraint(equalTo: thumbnail.heightAnchor, multiplier: 16/9).isActive = true
    }
    
    func setTitleConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 20).isActive = true
        title.heightAnchor.constraint(equalToConstant: 80).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
}

// An extension added to help load in the thumbnail imageview.
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
