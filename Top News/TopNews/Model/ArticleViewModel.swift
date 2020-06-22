//
//  ArticleViewModel.swift
//  Top News
//
//  Created by Jefin on 18/06/20.
//  Copyright © 2020 Jefin. All rights reserved.
//

import Foundation

struct ArticleListViewModel {
    
let article: [Articles]
    
}

struct NewsListViewModel {
    
let newsarticle: [Articles]
    
}

struct ArticleViewModel {
    
  private  let article : Articles
  
    
}

struct NewsViewModel {
   
private  let newsarticle : Articles
}

extension ArticleViewModel{
    
    init(_ article: Articles ) {
     
        self.article = article
        
    }
    

  
}

extension NewsViewModel {
    
    init(_ newsarticle: Articles) {
        
         self.newsarticle = newsarticle
    }
    

    
}
