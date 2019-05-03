//
//  MVVMViewController.swift
//  iOSConcepts
//
//  Created by Avijit Nagare on 03/05/19.
//  Copyright © 2019 Avijit Nagare. All rights reserved.
//



import UIKit
// Source https://www.agnosticdev.com/blog-entry/swift/researching-mvvm-swift

class MVVMViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ArticleModelDelegate {
    
    let articleModel = ArticleViewModel()
    var localArticles: [Article]?
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        articleModel.getAllArticles()
        localArticles =  articleModel.articlesData!.sortArticleDataAlpha()
        articleModel.articleDelegate = self
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func toggleDataSegmentControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            articleModel.getArticleData(index: 0)
        }else{
            articleModel.getArticleData(index: 1)
        }
    }
    func resetTableData(articles: [Article]) {
        localArticles = articles
        self.myTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localArticles!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let artVM = ArticleViewModel(article: localArticles![indexPath.row])
        cell.textLabel?.text = String("\(artVM!.articleTitle!) -\(artVM!.dateFormattedString!)")
        cell.imageView?.image = UIImage(data: localArticles![indexPath.row].imageData)
        return cell;
    }

}
