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
        let sb = UIStoryboard.init(name: "Login", bundle: nil)
        let vc = sb.instantiateInitialViewController()!;
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func toPageMenu(_ sender: UIButton) {
       let vc = BlogsVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func fullScreenImage(_ sender: UIButton) {
            let iVC = FullImageVC()
            iVC.imageToShow = UIImage(named: "swift")
            self.navigationController?.pushViewController(iVC, animated: true)
    }

}

