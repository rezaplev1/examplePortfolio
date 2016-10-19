//
//  CoreApiInterface.swift
//  PergiBareng
//
//  Created by Reza Pahlevi on 10/18/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

import Foundation
import SwiftyJSON

@objc protocol CoreApiDelegate {
     @objc func finish(interFace : CoreApiInterface, result : AnyObject)
}

class CoreApiInterface: CoreApi {
    
    var delegate : CoreApiDelegate?
    
    func start(){
        getRequest(param: param())
    }
    
    func param() -> [String : Any] {
        return [:]
    }
    
    override func success(data : NSDictionary) {
        
//        delegate?.finish(interFace: self, result: data)
        print(data)
    }
    
}
