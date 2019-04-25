//
//  WKWebViewController.swift
//  iOSConcepts
//
//  Created by Avijit Nagare on 11/03/19.
//  Copyright © 2019 Avijit Nagare. All rights reserved.
//

import UIKit
import WebKit

class WKWebViewController: UIViewController,WKNavigationDelegate,WKUIDelegate {
    
    @IBOutlet  var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://unipune.ac.in")
        self.webView.navigationDelegate = self
        self.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        self.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)
        
        self.webView.uiDelegate = self
        self.webView.load(URLRequest(url: url!))
        
//        let source = """
//    document.body.style.background = "#777";
//"""
//        let userScript = WKUserScript(source: source,
//                                      injectionTime: .atDocumentEnd,
//                                      forMainFrameOnly: true)
//        let userContentController = WKUserContentController()
//        userContentController.addUserScript(userScript)
//        let configuration = WKWebViewConfiguration()
//        configuration.userContentController = userContentController
//        self.webView = WKWebView(frame: self.view.bounds,
//                                 configuration: configuration)
        
        
        //        sleep(30)
        
        //Load Local Resources
        //        if let url = Bundle.main.url(forResource: "Test", withExtension: "html") {
        //            self.webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        //        }
        
        //        sleep(30)
        
        //Load from string
        
        //        let html = """
        //        <html>
        //        <body>
        //        <h1>Hello,Swift</h1>
        //        </body>
        //        </html>
        //        """
        //        self.webView.loadHTMLString(html, baseURL: Bundle.main.resourceURL)
        //        sleep(30)
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Start Loading")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      print("End Loading")
    }
    
    //uiDelegate
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let ac = UIAlertController(title: "Hey, listen!", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
        completionHandler()
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            print(Float(webView.estimatedProgress))
        }
        if keyPath == "title" {
            if let title = self.webView.title {
                print(title)
                self.title = title
            }
            //User visited pages.
            for page in self.webView.backForwardList.backList {
                print("User visited \(page.url.absoluteString)")
            }
            //Javasrcipt
            self.webView.evaluateJavaScript("document.getElementById('username').innerText") { (result, error) in
                if let result = result {
                    print(result)
                }
            }
            //Cookies
            self.webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
                for cookie in cookies {
                    if cookie.name == "authentication" {
                        self.webView.configuration.websiteDataStore.httpCookieStore.delete(cookie)
                    } else {
                        print("\(cookie.name) is set to \(cookie.value)")
                    }
                }
            }
            //Take Snapshot
            let config = WKSnapshotConfiguration()
            config.rect = CGRect(x: 0, y: 0, width: 150, height: 50)
            self.webView.takeSnapshot(with: nil) { image, error in
                if let image = image {
                    print(image.size)
                }
            }
            //Data Detector
            let config1 = WKWebViewConfiguration()
            config1.dataDetectorTypes = [.all]
            let webView = WKWebView(frame: .zero, configuration: config1)
        }
    }
    
    //    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    //        if let host = navigationAction.request.url {
    //            if host.host == "www.google.com" {
    //                UIApplication.shared.open(host)
    //                decisionHandler(.cancel)
    //                return
    //            }
    //        }
    //        decisionHandler(.allow)
    //    }
    
}

