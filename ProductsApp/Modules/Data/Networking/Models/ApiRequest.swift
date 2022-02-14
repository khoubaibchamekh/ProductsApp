//
//  ApiRequest.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 12/8/21.
//

import Foundation

class ApiRequest {
    
    let resource: URL
    let method: HttpMethod
    let header: [String: String]?
    let json: Data?
    
    init(resource: URL,
         method: HttpMethod = .get,
         header: [String: String]? = nil,
         json: Data? = nil) {
        
        self.resource = resource
        self.method = method
        self.header = header
        self.json = json
    }
}
