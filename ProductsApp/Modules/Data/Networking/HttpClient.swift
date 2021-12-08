//
//  HttpClient.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 12/8/21.
//

import Foundation

protocol HttpClient {
    func request<T: Decodable>(_ request: ApiRequest, completion: @escaping (Result<T, Error>) -> Void)
}
