//
//  NewsDetailViewController.swift
//  Top News
//
//  Created by Jefin on 18/06/20.
//  Copyright © 2020 Jefin. All rights reserved.
//

import Foundation
import UIKit

class NewsDetailViewController:UIViewController {
    
    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    @IBOutlet weak var newsImage: UIImageView!
    
    @IBOutlet weak var newsContentTextView: UITextView!
    
    var article: Articles!
    
override func viewDidLoad() {
   
   initialSetup()
}
    
func initialSetup(){
        
    self.TitleLabel.text = article.title?.uppercased()
    self.TitleLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
    self.DescriptionLabel.text = article.description
    self.newsContentTextView.text = article.content
    if let url = article.urlToImage {
        
    self.newsImage.loadImagefromUrl(urlString: url)
        
    }
    
        
        
    
}
    
}
