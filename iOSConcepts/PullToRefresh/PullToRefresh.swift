//
//  PullToRefresh.swift
//  iOSConcepts
//
//  Created by IMAC-0025 on 23/03/20.
//  Copyright © 2020 Avijit Nagare. All rights reserved.
//

import UIKit

struct BlogApiModel: Codable {
    var results: [BlogApi]?
    var page: PageInfo?
}
struct PageInfo: Codable {
    var number: Int?
    var size: Int?
    var totalCount: Int?
}
struct BlogApi: Codable {
    var id : String?
    var title: String?
}
class PullToRefresh: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let kPageSize = 15
    var refreshControl = UIRefreshControl()
    var fetchingData = false
    let cellIdentifire = "pullToRefreshCell"
    var blogApiModel: BlogApiModel?
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl.attributedTitle = NSAttributedString(string: "Pull To Refresh")
        refreshControl.addTarget(self, action: #selector(refreshBlogs), for: UIControl.Event.valueChanged)
        myTableView.addSubview(refreshControl)
        // Do any additional setup after loading the view.
    }
    @objc func refreshBlogs() {
          // Code to refresh table view
           
        getBlogs()
           
    }
    
    func getBlogs() {
        
             let param = [
               "pagenumber": 0,
               "pagesize": kPageSize
              ] as [String : Any]
         ApiManager.instance.getDataFromApi(api:.home, httpRequest:.post, params: param) { (data, response, error) in
            
                  do {
                  //  let str = String(decoding: data!, as: UTF8.self)

                          DispatchQueue.main.async {
                              //reload data
                         }
                  }
                    
                   if self.refreshControl.isRefreshing == true {
                       self.refreshControl.endRefreshing()
                   }
                       
            }
                 
              
        
       }
    
    func getNextPage(){
        
        if self.blogApiModel?.results?.count ?? 0  < self.blogApiModel?.page?.totalCount ?? 0 {
            let nextPage = (self.blogApiModel?.page?.number ?? 0) + 1
            getNextBlogs(pageNumber: nextPage)
        }
    }
    
    func getNextBlogs(pageNumber:Int) {
                    
           if fetchingData == true {
               return
           }
                  
          fetchingData = true
          let param = [ "pagenumber":pageNumber,"pagesize": kPageSize] as [String : Any]
          ApiManager.instance.getDataFromApi(api: .home, httpRequest: .post, params: param) {[weak self] (data, response, error) in
              do {
                  if let data = data {
                    //  let str = String(decoding: data, as: UTF8.self)
                    let tempModel = try JSONDecoder().decode(BlogApiModel.self, from: data)
                    
                    self?.blogApiModel?.results?.append(contentsOf: tempModel.results!)
                    self?.myTableView.reloadData()
                     
                  }
                  
              } catch {
                  print(error.localizedDescription)
              }
              
              self?.fetchingData = false
          }
           
       }
    
    //Table Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.blogApiModel?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier:cellIdentifire ) {
              
            cell.textLabel?.text = self.blogApiModel?.results?[indexPath.row].title
              
              
              return cell
          }
          
          return UITableViewCell()
    }
    

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if ((myTableView.contentOffset.y + myTableView.frame.size.height) >= myTableView.contentSize.height)
        {
             DispatchQueue.main.async {
                 self.getNextPage()
             }
        }
    }

}
