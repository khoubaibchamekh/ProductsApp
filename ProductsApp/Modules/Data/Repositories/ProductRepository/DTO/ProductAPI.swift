//
//  ProductAPI.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 12/8/21.
//

import Foundation

struct ProductAPI {
    let identifier: Int
    let name: String
    let descriptionText: String
    let price: Double
    let brand: BrandAPI
    let isSpecialBrand: Bool
    let smallImageURL: String
    let largeImageURL: String

    init(identifier: Int,
         name: String,
         descriptionText: String,
         price: Double,
         brand: BrandAPI,
         isSpecialBrand: Bool,
         smallImageURL: String,
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

extension ProductAPI: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case identifier = "product_id"
        case name = "product_name"
        case descriptionText = "description"
        case price
        case brand = "c_brand"
        case isSpecialBrand = "is_special_brand"
        case imageURLs = "images_url"
    }
    
    enum ImageURLsKeys: String, CodingKey {
        case small
        case large
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try values.decode(Int.self, forKey: .identifier)
        name = try values.decode(String.self, forKey: .name)
        descriptionText = try values.decode(String.self, forKey: .descriptionText)
        price = try values.decode(Double.self, forKey: .price)
        brand = try values.decode(BrandAPI.self, forKey: .brand)
        isSpecialBrand = try values.decode(Bool.self, forKey: .isSpecialBrand)
        let imageURLs = try values.nestedContainer(keyedBy: ImageURLsKeys.self, forKey: .imageURLs)
        smallImageURL = try imageURLs.decode(String.self, forKey: .small)
        largeImageURL = try imageURLs.decode(String.self, forKey: .large)
    }
}
