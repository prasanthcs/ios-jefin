//
//  Top_NewsTests.swift
//  Top NewsTests
//
//  Created by Jefin on 17/06/20.
//  Copyright © 2020 Jefin. All rights reserved.
//

import XCTest
@testable import TopNews

class TopNewsTests: XCTestCase {

func testArticle(){

let source = Source(id: "1", name: "one")
let article = Articles(source: source, author: "test", title: "title", description: "description", url: "www.apple.com", urlToImage: "www.apple.com", publishedAt: "22-09-2020", content: "news")
    
 let articleViewModel = ArticleViewModel(article)
    
XCTAssertNil(articleViewModel)
    
XCTAssertEqual(source.id, article.source?.id)
    
}

}
