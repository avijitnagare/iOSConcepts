//
//  ViewModel.swift
//  iOSConcepts
//
//  Created by Avijit Nagare on 03/05/19.
//  Copyright © 2019 Avijit Nagare. All rights reserved.
//

import Foundation

class ViewModel: NSObject {
    
    var movies: [String]?
    
    var client = Client()
    
    func modelMovies(completion: ()->() ) {
        
        client.fetchMovies(){ movies in
            self.movies = movies
        }
        
        completion()
    }
    
    
    func numberOfItems() -> Int {
        return self.movies!.count
    }
    func titleForRowAtIndexPath(indexPath: NSIndexPath) -> String{
        return movies![indexPath.row]
    }
}
