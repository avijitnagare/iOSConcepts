//
//  Client.swift
//  iOSConcepts
//
//  Created by Avijit Nagare on 03/05/19.
//  Copyright © 2019 Avijit Nagare. All rights reserved.
//

import Foundation


class Client {
    
    func fetchMovies(completion:([String]) -> ()) {
        completion(["Titanic","Dhoom", "Gangs Of Wasepur","Walk to Remember"])
    }
    
}
