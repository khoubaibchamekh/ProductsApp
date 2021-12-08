//
//  ProductListViewModel.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 12/8/21.
//

import Foundation

protocol ProductListViewModelOutput {
    func fetchProducts(completion: @escaping (Result<[PresentableProduct], Error>) -> Void)
}

class ProductListViewModel: ProductListViewModelOutput {
    let productRepository: ProductRepository
    
    init(productRepository: ProductRepository) {
        self.productRepository = productRepository
    }
    
    func fetchProducts(completion: @escaping (Result<[PresentableProduct], Error>) -> Void) {
        productRepository.fetch { [weak self] result in
            switch result {
            case .success(let response):
                let products = response.map {
                    PresentableProduct(
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
