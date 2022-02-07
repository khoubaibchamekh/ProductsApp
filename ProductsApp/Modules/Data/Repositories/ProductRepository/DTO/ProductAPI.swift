//
//  ProductAPI.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 12/8/21.
//

import Foundation

struct ProductAPI: Decodable {
    let identifier: String
    var description: String
    var location: String
    var imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case description
        case location
        case imageURL = "image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try values.decode(String.self, forKey: .identifier)
        description = try values.decodeIfPresent(String.self, forKey: .description) ?? ""
        location = try values.decodeIfPresent(String.self, forKey: .location) ?? ""
        imageURL = try values.decode(String.self, forKey: .imageURL)
    }
}
