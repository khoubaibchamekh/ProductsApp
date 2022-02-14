//
//  StorageContextTestsCase.swift
//  ProductsAppTests
//
//  Created by Khoubaib Chamekh on 14/2/2022.
//

import XCTest
@testable import ProductsApp

class StorageContextTestsCase: XCTestCase {
    
    func test_fetchExpectedDataSuccessfully() {
        let storableProduct1 = Product(
            identifier: 1,
            name: "",
            descriptionText: "",
            price: 0.0,
            brand: Brand(identifier: "1", name: ""),
            isSpecialBrand: false,
            smallImageURL: "",
            largeImageURL: ""
        ).mapToPersistenceObject()
        
        let storableProduct2 = Product(
            identifier: 2,
            name: "",
            descriptionText: "",
            price: 0.0,
            brand: Brand(identifier: "2", name: ""),
            isSpecialBrand: false,
            smallImageURL: "",
            largeImageURL: ""
        ).mapToPersistenceObject()

        let sut = makeSUT()

        let products = [storableProduct1, storableProduct2]
        try? sut.save(products)

        let result = sut.fetch(
            type(of: storableProduct1),
            options: FetchOptions(
                sorting: Sorting(key: "identifier", ascending: true)
            )
        )
        
        XCTAssert(result.count == products.count)
        result.enumerated().forEach { (index, product) in
            XCTAssert(product.identifier == products[index].identifier)
            XCTAssert(product.name == products[index].name)
        }
    }
    
    func test_fetchObjectWithPredicate() {
        let sut = makeSUT()
        let product1 = Product(
            identifier: 1,
            name: "",
            descriptionText: "",
            price: 0.0,
            brand: Brand(identifier: "1", name: ""),
            isSpecialBrand: false,
            smallImageURL: "",
            largeImageURL: ""
        ).mapToPersistenceObject()
        
        let product2 = Product(
            identifier: 2,
            name: "",
            descriptionText: "",
            price: 0.0,
            brand: Brand(identifier: "2", name: ""),
            isSpecialBrand: false,
            smallImageURL: "",
            largeImageURL: ""
        ).mapToPersistenceObject()
        
        try? sut.save([product1, product2])

        let result = sut.fetch(
            type(of: product1),
            options: FetchOptions(
                predicate: NSPredicate(format: "identifier == \(product1.identifier)")
            )
        )
        
        XCTAssert(result.count == 1)
        XCTAssert(result.first?.identifier == product1.identifier)
        XCTAssert(result.first?.name == product1.name)
    }
    
    func test_fetchUsingUnmanagedObjectType() {
        let sut = makeSUT()
        let product = FakeProduct(identifier: 1, name: "produit de test")
        try? sut.save([product])
        let result = sut.fetch(
            type(of: product),
            options: FetchOptions(
                predicate: NSPredicate(format: "identifier == \(product.identifier)")
            )
        )

        XCTAssertTrue(result.isEmpty)
    }
    
    //MARK: Helpers
    private func makeSUT() -> StorageContext {
        return RealmStorageContext(configuration: .inMemory(identifier: "MyInMemoryRealmFor" + name))
    }
}

struct FakeProduct: Storable {
    var identifier = 0
    var name = ""
}
