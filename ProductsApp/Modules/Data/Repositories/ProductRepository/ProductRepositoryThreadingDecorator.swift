//
//  ProductRepositoryThreadingDecorator.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 7/2/2022.
//

import Foundation

final class ProductRepositoryThreadingDecorator: ProductRepository {
    private let decoratee: ProductRepository
    
    init(_ decoratee: ProductRepository) {
        self.decoratee = decoratee
    }
    
    func fetch(completion: @escaping (Result<[Product], Error>) -> Void) {
        decoratee.fetch { result in
            Utilities.guaranteeMainThread {
                completion(result)
            }
        }
    }
}
