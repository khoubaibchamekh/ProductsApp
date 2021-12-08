//
//  ApiError.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 12/8/21.
//

import Foundation

enum ApiError: Equatable, Error {
    case dataError
    case nonHTTPResponse
    case serializationError
    case requestFailed(error: String?)
}
