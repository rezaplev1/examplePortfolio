//
//  PhotoApi.swift
//  PergiBareng
//
//  Created by Reza Pahlevi on 10/18/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

import Foundation


class PhotoApi: CoreApiInterface {
    override init () {
        
    }
    
    override func start() {
        super.start()
    }
    override func param() -> [String : Any]  {
       let parameters: [String : Any] = ["results": 5]
        return parameters
    }
}
