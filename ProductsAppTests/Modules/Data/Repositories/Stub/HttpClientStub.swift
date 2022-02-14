//
//  HttpClientStub.swift
//  ProductsAppTests
//
//  Created by Khoubaib Chamekh on 14/2/2022.
//

import Foundation
@testable import ProductsApp

class HttpClientStub<T: Decodable>: HttpClient {
    private let result: Result<T, ApiError>
    
    init(result: Result<T, ApiError>) {
        self.result = result
    }
    
    func request<T>(_ request: ApiRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        switch result {
        case let .success(response):
            if let response = response as? T {
                completion(.success(response))

            } else {
                completion(.failure(ApiError.dataError))
            }
            
        case let .failure(error):
            completion(.failure(error))
        }
    }
}
