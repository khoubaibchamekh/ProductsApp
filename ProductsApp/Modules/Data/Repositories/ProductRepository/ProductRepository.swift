//
//  ProductRepository.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 12/8/21.
//

import Foundation

protocol ProductRepository {
    func fetch(completion: @escaping (Result<[Product], Error>) -> Void)
}
