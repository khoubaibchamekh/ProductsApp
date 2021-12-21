//
//  ProductAPI.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 12/8/21.
//

import Foundation

struct ProductAPI: Decodable {
    let identifier: String
    let description: String
    let location: String
    let imageURL: String
}