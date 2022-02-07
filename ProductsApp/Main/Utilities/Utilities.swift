//
//  Utilities.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 7/2/2022.
//

import Foundation

enum Utilities {
    static func guaranteeMainThread(_ work: @escaping () -> Void) {
        if Thread.isMainThread {
            work()
        } else {
            DispatchQueue.main.async(execute: work)
        }
    }
}
