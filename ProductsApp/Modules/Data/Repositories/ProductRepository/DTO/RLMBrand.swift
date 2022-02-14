//
//  RLMBrand.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 13/2/2022.
//

import RealmSwift

class RLMBrand: Object {
    @Persisted(primaryKey: true) var identifier = ""
    @Persisted var name = ""
}
