//
//  FetchOptions.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 13/2/2022.
//

import Foundation

struct FetchOptions {
    var predicate: NSPredicate?
    var sorting: Sorting?
}

struct Sorting {
    var key: String
    var ascending = true
}
