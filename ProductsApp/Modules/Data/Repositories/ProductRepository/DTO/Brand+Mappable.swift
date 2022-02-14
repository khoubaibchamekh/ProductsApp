//
//  Brand+Mappable.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 13/2/2022.
//

import Foundation

extension Brand: MappableProtocol {
    typealias PersistenceType = RLMBrand

    func mapToPersistenceObject() -> RLMBrand {
        let brand = RLMBrand()
        brand.identifier = identifier
        brand.name = name
        return brand
    }
    
    static func mapFromPersistenceObject(_ object: RLMBrand) -> Brand {
        return Brand(identifier: object.identifier, name: object.name)
    }
}
