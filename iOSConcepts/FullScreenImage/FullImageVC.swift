//
//  FullImageVC.swift
//  birlasoftONE
//
//  Created by Dharmendra Chaudhary on 26/02/20.
//  Copyright © 2020 Birlasoft Ltd. All rights reserved.
//

import UIKit
//import SDWebImage

class FullImageVC: UIViewController , UIScrollViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    var imageUrl:String?
    var imageToShow: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        if let url = imageUrl {
            print(url)
           // imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "imagePlaceholder") )

        }else{
            if let image = imageToShow {
                imageView.image = image
            }
        }
        
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
