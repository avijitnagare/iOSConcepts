//
//  ApiManager.swift
//  birlasoftONE
//
//  Created by Dharmendra Chaudhary on 14/01/20.
//  Copyright © 2020 Birlasoft Ltd. All rights reserved.
//

import Foundation

enum ApiType:String {
    case home = "/home"
}

enum HttpRequestType:String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

public struct Api {
    static let baseURL = "https://test.com"
}
extension Dictionary {
    var queryString: String {
        var output: String = ""
        for (key,value) in self {
            output +=  "\(key)=\(value)&"
        }
        output = String(output.dropLast())
        return output
    }
}


class ApiManager: NSObject , URLSessionDelegate {
    
    static let instance = ApiManager()
    
    func getDataFromApi(api:ApiType,httpRequest:HttpRequestType,params:[String:Any],onCompletion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        var localParams = params
        localParams["Authorization"] = ""
        
        var serviceUrl:URL!
        let urlString = Api.baseURL + api.rawValue
        
        if localParams.count > 0 {
            switch httpRequest {
                
            case .get:
                
                let qString = localParams.queryString
                if let sUrl = URL(string: urlString + "?" + qString){
                    serviceUrl = sUrl
                }
                else
                {
                    let error = NSError(domain: "ServiceParam", code: -10, userInfo: nil)
                    onCompletion(nil,nil,error)
                    return
                }
                
            case .post,.put:
                if let sUrl = URL(string:urlString){
                    serviceUrl = sUrl
                }
                else
                {
                    let error = NSError(domain: "ServiceParam", code: -10, userInfo: nil)
                    onCompletion(nil,nil,error)
                    return
                }
            }
        } else {
            
            if let sUrl = URL(string:urlString){
                serviceUrl = sUrl
            }
            else
            {
                let error = NSError(domain: "ServiceParam", code: -10, userInfo: nil)
                onCompletion(nil,nil,error)
                return
            }
            
        }
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = httpRequest.rawValue
        if localParams.count > 0 {
                  if httpRequest ==  .post || httpRequest ==  .put  {
                      guard let httpBody = try? JSONSerialization.data(withJSONObject: localParams, options: []) else {
                          
                          let error = NSError(domain: "ServiceParam", code: -10, userInfo: nil)
                          onCompletion(nil,nil,error)
                          return
                      }
                      request.httpBody = httpBody
                      
                  }
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        
        let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
     let task =  session.dataTask(with: request) { (data, response, error) in
         if error == nil {
             
             DispatchQueue.main.async {
                 onCompletion(data,response,error)
             }
         }
             
     }
     
     task.resume()
        
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
        
        if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
            if let serverTrust = challenge.protectionSpace.serverTrust {
                var secresult = SecTrustResultType.invalid
                let status = SecTrustEvaluate(serverTrust, &secresult)
                
                if(errSecSuccess == status) {
                    if let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0) {
                        let serverCertificateData = SecCertificateCopyData(serverCertificate)
                        let data = CFDataGetBytePtr(serverCertificateData);
                        let size = CFDataGetLength(serverCertificateData);
                        let cert1 = NSData(bytes: data, length: size)
                        
                        if let file = Bundle.main.path(forResource: "BSLDigitalAssetManagement", ofType: "cer")
                        {
                            if let cert2 = NSData(contentsOfFile: file) {
                                if cert1.isEqual(to: cert2 as Data) {
                                    completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust:serverTrust))
                                    return
                                }}}}}}}
        // Pinning failed
        completionHandler(URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
    }
}
