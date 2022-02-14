//
//  URLSession+HTTPSession.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 13/2/2022.
//

import Foundation

extension URLSession: HTTPSession {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> HTTPSessionTask {
        return HTTPURLSessionTask(URLSession.shared.dataTask(with: request, completionHandler: completionHandler))
    }
}
