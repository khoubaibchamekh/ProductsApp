//
//  Product.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 12/8/21.
//

import Foundation

class Product {
    let identifier: String
    let description: String
    let location: String
    let imageURL: String
    
    init(identifier: String, description: String, location: String, imageURL: String) {
        self.identifier = identifier
        self.description = description
        self.location = location
        self.imageURL = imageURL
    }
}
