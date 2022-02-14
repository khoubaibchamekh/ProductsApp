//
//  Product+Mappable.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 13/2/2022.
//

import Foundation

extension Product: MappableProtocol {
    typealias PersistenceType = RLMProduct

    static func mapFromPersistenceObject(_ object: RLMProduct) -> Product {
        return Product(
            identifier: object.identifier,
            name: object.name,
            descriptionText: object.descriptionText,
            price: object.price,
            brand: Brand.mapFromPersistenceObject(object.brand!),
            isSpecialBrand: object.isSpecialBrand,
            smallImageURL: object.smallImageURL,
            largeImageURL: object.largeImageURL
        )
    }
    
    func mapToPersistenceObject() -> RLMProduct {
        let product = RLMProduct()
        product.identifier = identifier
        product.name = name
        product.descriptionText = descriptionText
        product.price = price
        product.brand = brand.mapToPersistenceObject()
        product.isSpecialBrand = isSpecialBrand
        product.smallImageURL = smallImageURL
        product.largeImageURL = largeImageURL
        return product
    }
}
