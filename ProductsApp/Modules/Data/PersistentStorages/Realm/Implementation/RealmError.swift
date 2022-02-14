//
//  RealmError.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 13/2/2022.
//

import Foundation

enum RealmError: Error {
    case eitherRealmIsNilOrNotRealmSpecificModel
}

extension RealmError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .eitherRealmIsNilOrNotRealmSpecificModel:
            return "Either realm is nil or not realm specific model"
        }
    }
}
