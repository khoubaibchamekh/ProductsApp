//
//  MappableProtocol.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 13/2/2022.
//

import Foundation

protocol MappableProtocol {
    
    associatedtype PersistenceType: Storable
    
    //MARK: - Method
    func mapToPersistenceObject() -> PersistenceType
    static func mapFromPersistenceObject(_ object: PersistenceType) -> Self
}
