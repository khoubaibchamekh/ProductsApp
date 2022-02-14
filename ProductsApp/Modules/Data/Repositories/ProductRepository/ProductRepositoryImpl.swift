//
//  ProductRepositoryImpl.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 7/2/2022.
//

import Foundation

final class ProductRepositoryImpl: ProductRepository {
    private let httpClient: HttpClient
    private let storageContext: StorageContext
    
    init(httpClient: HttpClient, storageContext: StorageContext) {
        self.httpClient = httpClient
        self.storageContext = storageContext
    }
    
    func fetch(completion: @escaping (Result<[Product], Error>) -> Void) {
        let apiRequest = ApiRequest(resource: Constants.productsEndPoint)
        httpClient.request(apiRequest) { [weak self] (result: Result<[ProductAPI], Error>) in
            switch result {
            case .success(let response):
                let products = response.map {
                    Product(
                        identifier: $0.identifier,
                        name: $0.name,
                        descriptionText: $0.descriptionText,
                        price: $0.price,
                        brand: Brand(identifier: $0.brand.identifier, name: $0.brand.name),
                        isSpecialBrand: $0.isSpecialBrand,
                        smallImageURL: $0.smallImageURL,
                        largeImageURL: $0.largeImageURL
                    )
                }
                
                try? self?.storageContext.save(products.map { $0.mapToPersistenceObject() })                
                completion(.success(products))
                
            case .failure(let error):
                if let products = self?.storageContext.fetch(Product.PersistenceType.self, options: nil),
                    !products.isEmpty {
                    completion(.success(products.map { Product.mapFromPersistenceObject($0) }))
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
}
