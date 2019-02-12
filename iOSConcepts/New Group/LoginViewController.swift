//
//  LoginViewController.swift
//  iOSConcepts
//
//  Created by Avijit Nagare on 12/02/19.
//  Copyright © 2019 Avijit Nagare. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txt_Password: UITextField!
    @IBOutlet weak var txt_EmailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        
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
