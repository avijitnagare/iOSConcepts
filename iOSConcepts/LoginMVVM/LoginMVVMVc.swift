//
//  LoginMVVMVc.swift
//  iOSConcepts
//
//  Created by IMAC-0025 on 24/05/20.
//  Copyright © 2020 Avijit Nagare. All rights reserved.
//

import UIKit

class LoginMVVMVc: UIViewController {

    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var loginViewModel = LoginVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblMessage.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        self.lblMessage.isHidden = true;
        guard let userName = self.txtUserName.text else {return}
        guard let password = self.txtPassword.text else {return}
        loginViewModel.loginCompletionHandler { (status, message) in
            if status {
                self.lblMessage.text = message
                self.lblMessage.isHidden = false
            }else{
                self.lblMessage.text = message
                self.lblMessage.isHidden = false
            }
        }
        loginViewModel.tryToLoginWith(userName, and: password)


    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
