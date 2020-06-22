//
//  WebServices.swift
//  Top News
//
//  Created by Jefin on 18/06/20.
//  Copyright © 2020 Jefin. All rights reserved.
//

import Foundation

class WebServices {
    
//MARK:- Webservice to fecth the articles
    
    func getArticles(url:URL, completion : @escaping(([Articles]?) -> ())){
        
        URLSession.shared.dataTask(with: url){data,response,error in
            
            if let error = error {
                
                print(error.localizedDescription)
                completion(nil)
            }
            guard  let data = data else { return }
                
                let articleList =  try? JSONDecoder().decode(Headlines.self, from: data)
                
                if let articleList = articleList {
                    
                    completion(articleList.articles)
                }
                
        }.resume()
        
    }
    
}
