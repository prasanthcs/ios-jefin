//
//  categoriesCell.swift
//  Top News
//
//  Created by Jefin on 18/06/20.
//  Copyright © 2020 Jefin. All rights reserved.
//

import Foundation
import UIKit

class categoriesCell: UICollectionViewCell {
    
@IBOutlet weak var categoryNameLabel: UILabel!
    
override func awakeFromNib() {
        
}

func setValues(categories: String) {
 
    self.categoryNameLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
    self.categoryNameLabel.text = categories
              
}
    
}
