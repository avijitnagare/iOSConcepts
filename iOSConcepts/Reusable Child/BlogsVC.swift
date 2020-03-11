//
//  BlogsVC.swift
//  birlasoftONE
//
//  Created by IMAC-0025 on 07/02/20.
//  Copyright © 2020 Birlasoft Ltd. All rights reserved.
//

import UIKit

class BlogsVC: UIViewController {

    @IBOutlet weak var buttonArticlesList : UIButton!
    @IBOutlet weak var buttonMyArticles: UIButton!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var grayView: UIView!
    @IBOutlet weak var contentView: UIView!

       private lazy var allPostViewController: SummaryViewController = {
           let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            var allPostSummaryViewController = storyboard.instantiateViewController(withIdentifier: "SummaryViewController") as! SummaryViewController
            self.add(asChildViewController: allPostSummaryViewController)
            return allPostSummaryViewController
        }()
        
        private lazy var myPostViewController: SessionsViewController = {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            var myPostSessionViewController = storyboard.instantiateViewController(withIdentifier: "SessionsViewController") as! SessionsViewController
            self.add(asChildViewController: myPostSessionViewController)
            return myPostSessionViewController
        }()
        
    
        override func viewDidLoad() {
            super.viewDidLoad()
            setupView()
        }
        
        func setupView(){
            self.lineView.backgroundColor = UIColor.red
            self.buttonArticlesList.setTitleColor(UIColor.orange, for: .normal)
            self.buttonMyArticles.setTitleColor(UIColor.orange, for: .normal)
            let button = UIButton(type: .roundedRect)
            button.tag = 0
            updateView(button)
        }
   
    
        
        @IBAction func updateView(_ sender: UIButton) {
            if sender.tag == 0 {
                    UIView.animate(withDuration: 0.5) {
                        self.lineView.transform = .identity
                    }
                    remove(asChildViewController: myPostViewController)
                    add(asChildViewController: allPostViewController)
                } else {
                    UIView.animate(withDuration: 0.5) {
                        self.lineView.transform = CGAffineTransform(translationX: self.grayView.frame.size.width/2, y: 0)
                    }
                    remove(asChildViewController: allPostViewController)
                    add(asChildViewController: myPostViewController)
            }
        }
        private func add(asChildViewController viewController: UIViewController) {
            addChild(viewController)
            self.contentView.addSubview(viewController.view)
            viewController.view.frame = view.bounds
           // viewController.view.bindFrameToSuperviewBounds() //gogole this extension if botton edge not fit
            viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            viewController.didMove(toParent: self)
        }
   
        
        private func remove(asChildViewController viewController: UIViewController) {
            viewController.willMove(toParent: nil)
            viewController.view.removeFromSuperview()
            viewController.removeFromParent()
        }


}

