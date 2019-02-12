//
//  ViewController.swift
//  iOSConcepts
//
//  Created by Avijit Nagare on 12/02/19.
//  Copyright © 2019 Avijit Nagare. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func toLoginController(_ sender: UIButton) {
        self.performSegue(withIdentifier: "Login", sender: self)
    }
    
}

