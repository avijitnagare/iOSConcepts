//
//  LoginModel.swift
//  iOSConcepts
//
//  Created by IMAC-0025 on 11/03/20.
//  Copyright © 2020 Avijit Nagare. All rights reserved.
//

import Foundation

protocol LoginModelDelegate {
    func viewToModelPassing(email: String, password: String)
}
protocol LoginModelToViewDelegate {
    func modelToViewDataPasssing()
}

class LoginModel: LoginModelDelegate {
   
    var email: String?
    var password: String?
    
    var delegate :  LoginModelDelegate?
    
    func viewToModelPassing(email: String, password: String) {
        self.email = email
        self.password = password
        
        sleep(5)
        
        //self.delegate?.modelToViewDataPasssing()
    }
       
}
