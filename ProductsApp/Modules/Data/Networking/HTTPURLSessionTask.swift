//
//  HTTPURLSessionTask.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 13/2/2022.
//

import Foundation

class HTTPURLSessionTask: HTTPSessionTask {
    private let sessionDataTask: URLSessionDataTask
    
    init(_ sessionDataTask: URLSessionDataTask) {
        self.sessionDataTask = sessionDataTask
    }
    
    func resume() {
        sessionDataTask.resume()
    }
}
