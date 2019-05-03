//
//  Article.swift
//  iOSConcepts
//
//  Created by Avijit Nagare on 03/05/19.
//  Copyright © 2019 Avijit Nagare. All rights reserved.
//

import Foundation

class Article {
    var title: String
    var date: Date
    var imageData: Data
    
    init(title: String, date: Date, imageData: Data)
    {
        self.title = title
        self.date = date
        self.imageData = imageData
    }
}
