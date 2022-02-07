//
//  ProductsAPIResponse.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 7/2/2022.
//

import Foundation

struct ProductsAPIResponse: Decodable {
    let items: [ProductAPI]
}
