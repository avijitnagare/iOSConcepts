//
//  TestCaseViewController.swift
//  iOSConcepts
//
//  Created by Avijit Nagare on 24/04/19.
//  Copyright © 2019 Avijit Nagare. All rights reserved.
//

import UIKit

class TestCaseViewController: UIViewController {

    override func viewDidLoad() {
        
        let ferrari = Car(type: .Sport, transmission: .Drive)
        ferrari.start(minute: 120)
        print(ferrari.miles)
        
    }
    
}
