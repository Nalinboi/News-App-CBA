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
    var sourceTitle = UILabel()
    var datePublished = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(thumbnail)
        addSubview(title)
        addSubview(sourceTitle)
        addSubview(datePublished)
        
        configureThumbnail()
        configureTitle()
        configureSourceTitle()
        configureDatePublished()
    }
    
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 10
    }
    
    func set(article: Article) {
        datePublished.text = article.publishedAt.description
        sourceTitle.text = article.source.name
        
        if let urlstring = article.urlToImage { // setting the table cell to be a thumbnail image (loading) followed by the article title
            if let url = URL(string: urlstring) {
                thumbnail.load(url: url)
            }
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
    
    func configureDatePublished() {
        datePublished.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.ultraLight)
        datePublished.numberOfLines = 0
        datePublished.adjustsFontSizeToFitWidth = true
        setDateConstraints()
    }
    
    func configureSourceTitle() {
        sourceTitle.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)
        sourceTitle.numberOfLines = 0
        sourceTitle.adjustsFontSizeToFitWidth = true
        setSourceTitleConstraints()
    }
    
    func configureThumbnail() {
        thumbnail.layer.cornerRadius = 10
        thumbnail.clipsToBounds = true
        setThumbnailConstraints()
    }
    
    func configureTitle() {
        title.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        title.numberOfLines = 0
        title.adjustsFontSizeToFitWidth = true
        setTitleConstraints()
    }

    
    func setThumbnailConstraints() {
        thumbnail.translatesAutoresizingMaskIntoConstraints = false
        
        thumbnail.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -65).isActive = true
        thumbnail.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        thumbnail.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true

        thumbnail.widthAnchor.constraint(equalTo: thumbnail.heightAnchor, multiplier: 16/9).isActive = true
        
        
        //        thumbnail.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        //        thumbnail.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        //        thumbnail.heightAnchor.constraint(equalToConstant: 80).isActive = true
        //        thumbnail.widthAnchor.constraint(equalTo: thumbnail.heightAnchor, multiplier: 16/9).isActive = true
    }
    
    func setTitleConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: centerYAnchor, constant: 50).isActive = true
        title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
        //        title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        //        title.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 20).isActive = true
        //        title.heightAnchor.constraint(equalToConstant: 80).isActive = true
        //        title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
    func setSourceTitleConstraints() {
        sourceTitle.translatesAutoresizingMaskIntoConstraints = false
        sourceTitle.topAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
        sourceTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        sourceTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
    func setDateConstraints() {
        datePublished.translatesAutoresizingMaskIntoConstraints = false
        datePublished.topAnchor.constraint(equalTo: bottomAnchor, constant: -25).isActive = true
        datePublished.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -180).isActive = true
        datePublished.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
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
