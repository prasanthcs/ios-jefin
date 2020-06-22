//
//  Model.swift
//  Top News
//
//  Created by Jefin on 17/06/20.
//  Copyright © 2020 Jefin. All rights reserved.
//

import Foundation

struct Headlines: Decodable {
  
let status: String?
let totalResults: Int?
let articles: [Articles]?
    
}

struct Articles: Decodable {
  
let source : Source?
let author : String?
let title : String?
let description : String?
let url : String?
let urlToImage : String?
let publishedAt : String?
let content : String?
    
}

struct Source: Decodable {
    
    let id : String?
    let name : String?
}


