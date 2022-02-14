//
//  BrandAPI.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 13/2/2022.
//

import Foundation

struct BrandAPI {
    let identifier: String
    let name: String
    
    init(identifier: String, name: String) {
        self.identifier = identifier
        self.name = name
    }
}

extension BrandAPI: Decodable {
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
    }
}
