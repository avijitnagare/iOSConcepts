//
//  ArticleData.swift
//  iOSConcepts
//
//  Created by Avijit Nagare on 03/05/19.
//  Copyright © 2019 Avijit Nagare. All rights reserved.
//

import Foundation

class ArticleData {
    var articles = [Article]()
    
    init(articleArray: [Article]) {
        self.articles = articleArray
    }
    
    func sortArticleDataAlpha() ->[Article] {
        return self.articles.sorted(by: { $0.title < $1.title })
    }
    func sortArticleDataByDate() ->[Article] {
        return self.articles.sorted(by: { $0.date < $1.date })
    }
}
