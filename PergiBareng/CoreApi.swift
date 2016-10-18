//
//  CoreApi.swift
//  PergiBareng
//
//  Created by Reza Pahlevi on 10/11/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

typealias ServiceResponse = (JSON, NSError?) -> Void

class CoreApi : NSObject {
    static let sharedInstance = CoreApi()
    
    func getRequest(param:Parameters){
        Alamofire.request("https://randomuser.me/api/", parameters : param).responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                let responsePostArray = response.result.value as! NSDictionary
                print("JSON: \(JSON)")
                self.success(data: response.result.value as! NSDictionary);
            }else {
                print("error")
            }
            
        }
        
    }
    func success(data : NSDictionary) {
    
    }
    
    
}

