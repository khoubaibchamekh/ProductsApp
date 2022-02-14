//
//  RLMProduct.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 13/2/2022.
//

import RealmSwift

class RLMProduct: Object {
    @Persisted(primaryKey: true) var identifier = 0
    @Persisted var name = ""
    @Persisted var descriptionText = ""
    @Persisted var price = 0.0
    @Persisted var brand: RLMBrand?
    @Persisted var isSpecialBrand = false
    @Persisted var smallImageURL = ""
    @Persisted var largeImageURL = ""
}
