//
//  PostCollectionViewCell.swift
//  armut-main
//
//  Created by Bahar on 14.02.2021.
//

import UIKit
import SDWebImage

class PostCollectionViewCell : UICollectionViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    func setupCell(imageURL: String , title: String , categoryText: String) {
        titleLabel.text = title
        categoryLabel.text = categoryText.uppercased()
        guard let url = URL(string: imageURL) else { return }
        postImageView.sd_setImage(with: url)
        
        postImageView.layer.cornerRadius = 5
    }
}
    
