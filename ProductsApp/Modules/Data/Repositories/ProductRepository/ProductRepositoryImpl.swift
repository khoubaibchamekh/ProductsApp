//
//  ProductRepositoryImpl.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 7/2/2022.
//

import Foundation

class ProductRepositoryImpl: ProductRepository {
    let httpClient: HttpClient
    private let productsEndPoint = "https://sephoraios.github.io/items.json"
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    func fetch(completion: @escaping (Result<[Product], Error>) -> Void) {
        guard let url = URL(string: productsEndPoint) else {
            completion(.failure(ApiError.requestFailed(error: "Invalid URL")))
            return
        }
        
        let apiRequest = ApiRequest(resource: url)
        httpClient.request(apiRequest) { (result: Result<ProductsAPIResponse, Error>) in
            switch result {
            case .success(let response):
                let products = response.items.map {
                    Product(
                        identifier: $0.identifier,
                        description: $0.description,
                        location: $0.location,
                        imageURL: $0.imageURL
                    )
                }
                
                completion(.success(products))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
