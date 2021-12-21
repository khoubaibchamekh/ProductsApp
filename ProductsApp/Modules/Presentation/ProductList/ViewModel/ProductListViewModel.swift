//
//  ProductListViewModel.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 12/8/21.
//

import Foundation

protocol ProductListViewModelProtocol {
    func fetchProducts(completion: @escaping (Result<[PresentableProduct], Error>) -> Void)
}

class ProductListViewModel: ProductListViewModelProtocol {
    let productRepository: ProductRepository
    
    init(productRepository: ProductRepository) {
        self.productRepository = productRepository
    }
    
    func fetchProducts(completion: @escaping (Result<[PresentableProduct], Error>) -> Void) {
        productRepository.fetch { result in
            switch result {
            case .success(let response):
                let products = response.map {
                    PresentableProduct(
                        identifier: $0.identifier,
                        description: $0.description,
                        location: $0.location,
                        imageURL: URL(string: $0.imageURL)
                    )
                }
                
                completion(.success(products))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
