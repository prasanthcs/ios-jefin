//
//  NewsListViewController.swift
//  Top News
//
//  Created by Jefin on 17/06/20.
//  Copyright © 2020 Jefin. All rights reserved.
//

import UIKit


class NewsListViewController: UIViewController {

    @IBOutlet weak var headlinesCollection: UICollectionView!
    
    @IBOutlet weak var categoriesCollection: UICollectionView!
    
    @IBOutlet weak var newsTable: UITableView!
    
    var timer: Timer?
    var currentPage: Int = 0
    var selectedCategory:Int = 0
    private var articleViewModel: ArticleListViewModel!
    private var newsViewModel: NewsListViewModel!
    var reachability :  Reachability?
    
    @IBOutlet weak var NoconnectionView: UIView!
    
    override func viewDidLoad() {
        
    super.viewDidLoad()
    
    initialSetup()
       
    
    }
    
    

    func initialSetup(){
      
    self.headlinesCollection.contentInsetAdjustmentBehavior = .never
    headlinesCollection.isPagingEnabled = true
    NoconnectionView.isHidden = true
    timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    CheckInternetConnection()
 
        
    }
    
    
    func CheckInternetConnection() {
     
        NotificationCenter.default.addObserver(self, selector: #selector(internetChanged), name: Notification.Name.reachabilityChanged, object: reachability)
             
         
        do {
             reachability = try Reachability()
             
             try reachability?.startNotifier()
                    
                } catch let err {
                    
                    print(err)
        }
        
        
    }
    
    func getHeadlines() {
        
        let urlString = Helper.headlinesAPI+Helper.APIKey
        guard let url = URL(string: urlString) else { return }
        
        WebServices().getArticles(url: url) { articles in
            
            guard let articles = articles else { return }
            
            self.articleViewModel = ArticleListViewModel(article: articles)
            
            DispatchQueue.main.async {
                
                self.headlinesCollection.reloadData()
            }
            
        }
        
    }
    
    func getCategorywiseNews() {
        
        let urlString = Helper.newsAPI+Helper.Categories[selectedCategory].lowercased()+"&apiKey="+Helper.APIKey
        
        guard let url = URL(string: urlString) else { return }
               
               WebServices().getArticles(url: url) { articles in
                   
                   guard let articles = articles else { return }
                   
                   self.newsViewModel = NewsListViewModel(newsarticle: articles)
                   
                   DispatchQueue.main.async {
                       
                     self.newsTable.reloadData()
                   }
                   
    }
        
    }
    
    //MARK: Observer to check the reachability change
    
    @objc func internetChanged(note: Notification){
        
        let reachability = note.object as! Reachability
        
           if reachability.connection != .unavailable  {
               
             DispatchQueue.main.async {
                               
                 self.NoconnectionView.isHidden = true
                  
             }
              
                getHeadlines()
            
                getCategorywiseNews()
        
            } else {
                
                DispatchQueue.main.async {
                             
                self.NoconnectionView.isHidden = false
                }
                Helper.showAlert(message: "Please check your network connectivity")
            }
        
    }
    
    //MARK: - Auto scroll for the headlines collection
    
    @objc func runTimedCode() {
       
        var index = IndexPath(row: currentPage, section: 0)
        
        if(articleViewModel != nil) {
            
        if(currentPage == articleViewModel.article.count - 1 ) {
            
            currentPage = 0
            
            
        } else {
            
            currentPage += 1
            
        }
        DispatchQueue.main.async {
            
            self.headlinesCollection.scrollToItem(at: index, at: .right, animated: true)
        
        }
    }
    }
    
}

extension NewsListViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
    var size = CGSize.zero
        
    if(collectionView == headlinesCollection) {
        
     size = CGSize(width:headlinesCollection.frame.size.width,height:headlinesCollection.frame.size.height)
        
    } else {
        
    size = CGSize(width:categoriesCollection.frame.size.width/3,height:60)
        
    }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
    }
    
   func collectionView(_ collectionView: UICollectionView,
    willDisplay cell: UICollectionViewCell,
    forItemAt indexPath: IndexPath) {
       
    cell.alpha = 0
    UIView.animate(withDuration: 1.0) {
              
    cell.alpha = 1
        
    }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    
   
        
     }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(collectionView == headlinesCollection) {
            
            return self.articleViewModel == nil ? 0: articleViewModel.article.count
            
        } else {
            
            return Helper.Categories.count
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(collectionView == categoriesCollection) {
          
       
            
        selectedCategory = indexPath.row
        var index = IndexPath(row: selectedCategory, section: 0)
        categoriesCollection.scrollToItem(at: index, at: .right, animated: true)
            
        DispatchQueue.main.async {
            
            self.categoriesCollection.reloadData()
            self.getCategorywiseNews()
        }
        
        } else {
          
            let VC = self.storyboard?.instantiateViewController(identifier: "NewsDetailViewController") as! NewsDetailViewController
            let article = articleViewModel.article[indexPath.row]
            VC.article = article
            self.navigationController?.pushViewController(VC, animated: true)
            
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         if(collectionView == headlinesCollection) {
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Helper.headlineCellId, for: indexPath) as! headlineCell
        
   
        let article = articleViewModel.article[indexPath.row]
            
         cell.setValues(article: article)
         
        return cell
            
         } else {
            
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Helper.categoriesCellId, for: indexPath) as! categoriesCell
            
        if(indexPath.row == selectedCategory) {
                         
            cell.categoryNameLabel.alpha = 1.0
                         
            } else {
            cell.categoryNameLabel.alpha = 0.5
                         
         }
          cell.setValues(categories: Helper.Categories[indexPath.row])
          return cell
            
        }
        
    }
    
}

extension NewsListViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         return self.newsViewModel == nil ? 0: newsViewModel.newsarticle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: Helper.newsCellId, for: indexPath) as! newsCell
        
        let article = newsViewModel.newsarticle[indexPath.row]
        cell.selectionStyle = .none
        cell.setValues(article: article)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let VC = self.storyboard?.instantiateViewController(identifier: "NewsDetailViewController") as! NewsDetailViewController
        let article = newsViewModel.newsarticle[indexPath.row]
        VC.article = article
        self.navigationController?.pushViewController(VC, animated: true)
    
    }
}
