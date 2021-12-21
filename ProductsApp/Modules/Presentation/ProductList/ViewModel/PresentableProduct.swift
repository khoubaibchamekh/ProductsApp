//
//  PresentableProduct.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 12/8/21.
//

import Foundation

struct PresentableProduct: Equatable, Hashable {
    let identifier: String
    let description: String
    let location: String
    let imageURL: URL?
}
