//
//  ScrollVC.swift
//  iOSConcepts
//
//  Created by IMAC-0025 on 12/02/20.
//  Copyright © 2020 Avijit Nagare. All rights reserved.
//

import UIKit

class ScrollVC: UIViewController, UIScrollViewDelegate {
    
     @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        // Do any additional setup after loading the view.
    }
    // MARK: - ScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        
        let pageWidth: CGFloat = scrollView.frame.width
        
     let _: CGFloat = floor((scrollView.contentOffset.x - pageWidth/2) / pageWidth) + 1
        
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
