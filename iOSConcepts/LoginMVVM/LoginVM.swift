//
//  LoginVM.swift
//  iOSConcepts
//
//  Created by IMAC-0025 on 24/05/20.
//  Copyright © 2020 Avijit Nagare. All rights reserved.
//

import UIKit

class LoginVM: NSObject {
    
    var user: User!
    var username: String {
        return user.userName
    }
    var email: String {
        return user.email
    }
    
    typealias loginCallBack = (_ status: Bool, _ message: String) -> Void
    
    var loginCallBackObject: loginCallBack?
    
    func tryToLoginWith(_ username: String, and password: String) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {
            if username.count != 0 {
                       if password.count != 0 {
                        self.verifyUserWith(username, and: password)
                       }else{
                           //password empty
                           self.loginCallBackObject?(false, "Password Should Not Empty")
                       }
                       
            }else {
                       //email empty
                       self.loginCallBackObject?(false, "UserName Should Not Empty")
             }
        }
       
    }
    
    fileprivate func verifyUserWith(_ username: String, and password: String) {
        if username == "test"  && password == "123" {
             user = User(userName:username , email: "\(username)@gmail.com")
             self.loginCallBackObject?(true, "Login Successful")
        }else{
            //invalid credentials
            self.loginCallBackObject?(false, "Enter Valid Credentials")
        }
    }
    
    func loginCompletionHandler(callback: @escaping loginCallBack) {
        self.loginCallBackObject = callback
    }

}
