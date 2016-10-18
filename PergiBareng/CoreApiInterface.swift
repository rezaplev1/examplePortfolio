//
//  CoreApiInterface.swift
//  PergiBareng
//
//  Created by Reza Pahlevi on 10/18/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

import Foundation
import SwiftyJSON

class CoreApiInterface: CoreApi {
    
    func start(){
//        let response = CoreApi.sharedInstance.getRequest(param: param()) ->response{
//        
//        }
        getRequest(param: param())
    }
    
    func param() -> [String : Any] {
        return [:]
    }
    override func success(data : NSDictionary) {
        
//        let responsePostArray = data as! NSDictionary

        print(data)
    }
    
}
