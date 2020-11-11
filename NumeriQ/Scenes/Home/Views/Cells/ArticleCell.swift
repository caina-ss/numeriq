//
//  ArticleCell.swift
//  NumeriQ
//
//  Created by Caina Souza on 2020-11-10.
//  Copyright © 2020 Quebecor. All rights reserved.
//

import UIKit
import AlamofireImage

class ArticleCell: UICollectionViewCell {
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    /// Configures the view with a given article.
    /// - Parameter article: The article to populate the view with.
    func configure(article: Article) {
        sourceLabel.text = article.source.name
        titleLabel.text = article.title
        descriptionLabel.text = article.description

        if let url = URL(string: article.urlToImage) {
            photoView.af.setImage(withURL: url)
        }
    }

}
