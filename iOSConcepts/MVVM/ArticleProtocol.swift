//
//  ArticleProtocol.swift
//  iOSConcepts
//
//  Created by Avijit Nagare on 03/05/19.
//  Copyright © 2019 Avijit Nagare. All rights reserved.
//

import Foundation

protocol ArticleModelDelegate {
    func resetTableData(articles:[Article])
}
