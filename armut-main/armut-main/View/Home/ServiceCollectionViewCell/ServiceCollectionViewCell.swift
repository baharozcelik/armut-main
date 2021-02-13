//
//  ServiceCollectionViewCell.swift
//  armut-main
//
//  Created by Bahar on 13.02.2021.
//

import UIKit
import SDWebImage

class ServiceCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet weak var serviceImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var proLabel: UILabel!
    
    
    func setupCell(imageURL: String , title: String , proText: String) {
        titleLabel.text = title
        proLabel.text = proText + " pros near you"
        
        guard let url = URL(string: imageURL) else { return }
        serviceImageView.sd_setImage(with: url)
        
        serviceImageView.layer.cornerRadius = 5
    }
}

