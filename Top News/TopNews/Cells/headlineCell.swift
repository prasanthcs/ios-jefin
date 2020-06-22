//
//  headlineCell.swift
//  Top News
//
//  Created by Jefin on 17/06/20.
//  Copyright © 2020 Jefin. All rights reserved.
//

import Foundation
import UIKit

class headlineCell:UICollectionViewCell {
    
    
    @IBOutlet weak var headlineImage: UIImageView!
    
    @IBOutlet weak var headlineLabel: UILabel!
    
    override func awakeFromNib() {
        
        
    }
    
    func setValues(article: Articles) {
     
    self.headlineLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
    self.headlineLabel.text = article.title
    if let url = article.urlToImage {
    self.headlineImage.loadImagefromUrl(urlString: url)
    }
        
    }
}
