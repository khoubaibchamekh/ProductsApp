//
//  ProductListViewModel.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 12/8/21.
//

import Foundation
import RxRelay

protocol ProductListViewModelProtocol {
    var tableDataSource: BehaviorRelay<[ProductCellViewModel]> { get }
    func fetchProducts()
}

class ProductListViewModel: ProductListViewModelProtocol {
    let productRepository: ProductRepository
    var tableDataSource = BehaviorRelay<[ProductCellViewModel]>(value: [])
    
    init(productRepository: ProductRepository) {
        self.productRepository = productRepository
    }
    
    func fetchProducts() {
        productRepository.fetch { [weak self] result in
            switch result {
            case .success(let response):
                let products = response
                    .sorted { $0.isSpecialBrand && !$1.isSpecialBrand }
                    .map {
                        ProductCellViewModel(
                        identifier: $0.identifier,
                        name: $0.name,
                        price: $0.price,
                        description: $0.descriptionText,
                        imageURL: URL(string: $0.smallImageURL),
                        brandName: $0.brand.name
                    )
                }
                
                self?.tableDataSource.accept(products)
                
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
