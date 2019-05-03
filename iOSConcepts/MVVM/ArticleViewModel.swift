//
//  ArticleViewModel.swift
//  iOSConcepts
//
//  Created by Avijit Nagare on 03/05/19.
//  Copyright © 2019 Avijit Nagare. All rights reserved.
//

import UIKit

class ArticleViewModel {
    
    var articleDelegate: ArticleModelDelegate?
    
    private var article: Article?
    
    var articlesData: ArticleData?
    
    var articleTitle: String? {
        return article!.title
    }
    var dateFormattedString: String? {
        if let dateVal = article?.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            return formatter.string(from: dateVal)
        }else{ return nil}
    }
    
    var image: Data? {
        if let imageData = article?.imageData {
            return imageData
        }else{ return nil }
    }

    
    convenience init? (article: Article) {
        self.init()
        self.article = article
    }
    
    
    func getArticleData(index: Int) {
        if index==0 {
            self.articleDelegate?.resetTableData(articles: articlesData!.sortArticleDataAlpha())
        }else{
            self.articleDelegate?.resetTableData(articles: articlesData!.sortArticleDataByDate())
        }
    }
    
    func getAllArticles() {
        var newArticles = [Article]()
        
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
        
        newArticles.append(Article(title: "Great Swift Article", date: dateFormatter.date(from:"18-10-2016")!, imageData: UIImage(named: "swift")!.pngData()!))
        newArticles.append(Article(title: "Excellent Objective-c", date: dateFormatter.date(from:"06-10-2016")!, imageData: UIImage(named: "apple")!.pngData()!))
        newArticles.append(Article(title: "Awesome Python Article", date: dateFormatter.date(from:"14-10-2016")!, imageData: UIImage(named: "python")!.pngData()!))
        newArticles.append(Article(title: "JavaScript Article", date: dateFormatter.date(from:"10-10-2016")!, imageData: UIImage(named: "javascript")!.pngData()!))
        self.articlesData = ArticleData(articleArray: newArticles)
    }
}
