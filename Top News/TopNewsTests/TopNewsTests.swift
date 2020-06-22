//
//  TopNewsTests.swift
//  TopNewsTests
//
//  Created by Jefin on 18/06/20.
//  Copyright © 2020 Jefin. All rights reserved.
//

import XCTest
@testable import TopNews

class TopNewsTests: XCTestCase {

func testarticle() {


let source = Source(id: "1", name: "test")
let article = Articles(source: source, author: "name", title: "title", description: "desc", url: "www.apple.com", urlToImage: "www.apple.com", publishedAt: "22-06-2020", content: "content")
let articleViewModel = ArticleListViewModel(article: [article])
XCTAssertEqual(article.title, articleViewModel.article[0].title)
XCTAssertEqual(article.description, articleViewModel.article[0].description)
XCTAssertEqual(article.urlToImage, articleViewModel.article[0].urlToImage)
XCTAssertEqual(article.content, articleViewModel.article[0].content)

XCTAssertNotNil(source)
XCTAssertNotNil(articleViewModel.article)
    
    
    
}
    
func testnewsarticle() {
  
let source = Source(id: "1", name: "test")
let article = Articles(source: source, author: "name", title: "title", description: "desc", url: "www.apple.com", urlToImage: "www.apple.com", publishedAt: "22-06-2020", content: "content")
let newsViewModel = NewsListViewModel(newsarticle: [article])
        
XCTAssertEqual(article.title, newsViewModel.newsarticle[0].title)
XCTAssertEqual(article.description, newsViewModel.newsarticle[0].description)
XCTAssertEqual(article.urlToImage, newsViewModel.newsarticle[0].urlToImage)
XCTAssertEqual(article.content, newsViewModel.newsarticle[0].content)
        
XCTAssertNotNil(newsViewModel.newsarticle)

}

    



}
