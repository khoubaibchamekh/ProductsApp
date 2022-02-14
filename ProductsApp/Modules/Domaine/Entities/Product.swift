//
//  Product.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 12/8/21.
//

import Foundation

final class Product {
    let identifier: Int
    let name: String
    let descriptionText: String
    let price: Double
    let brand: Brand
    let isSpecialBrand: Bool
    let smallImageURL: String
    let largeImageURL: String
    
    init(identifier: Int,
         name: String,
         descriptionText: String,
         price: Double,
         brand: Brand,
         isSpecialBrand: Bool,
         smallImageURL:String,
         largeImageURL: String) {
        
        self.identifier = identifier
        self.name = name
        self.descriptionText = descriptionText
        self.price = price
        self.brand = brand
        self.isSpecialBrand = isSpecialBrand
        self.smallImageURL = smallImageURL
        self.largeImageURL = largeImageURL
    }
}
