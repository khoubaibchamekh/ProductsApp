//
//  StorageContext.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 13/2/2022.
//

import Foundation

protocol StorageContext {
    func fetch<T: Storable>(_ model: T.Type, options: FetchOptions?) -> [T]
    func save<T: Storable>(_ objects: [T]) throws
}
