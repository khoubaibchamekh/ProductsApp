//
//  ProductRepositoryIntegrationTests.swift
//  ProductsAppTests
//
//  Created by Khoubaib Chamekh on 14/2/2022.
//

import XCTest
@testable import ProductsApp

class ProductRepositoryIntegrationTests: XCTestCase {

    func test_productCachedAfterFetch() {
        let apiResponse = [
            ProductAPI(
                identifier: 1,
                name: "DIOR",
                descriptionText: "",
                price: 100,
                brand: BrandAPI(identifier: "", name: ""),
                isSpecialBrand: true,
                smallImageURL: "",
                largeImageURL: ""
            )
        ]
        
        let storageContext = RealmStorageContext(configuration: .inMemory(identifier: "MyInMemoryRealmFor" + name))
        let sut = makeSUT(
            httpClient: HttpClientStub<[ProductAPI]>(result: .success(apiResponse)),
            storageContext: storageContext
        )
        
        let expectation = XCTestExpectation(description: "Expecting \(apiResponse.count) product")
        sut.fetch { result in
            expectation.fulfill()
            switch result {
            case let .success(products):
                let expectedResult = storageContext.fetch(Product.PersistenceType.self, options: nil)
                XCTAssertEqual(products.count, expectedResult.count)
                products.enumerated().forEach { index, product in
                    XCTAssertEqual(product.identifier, expectedResult[index].identifier)
                    XCTAssertEqual(product.name, expectedResult[index].name)
                }
                
            case let .failure(error):
                XCTAssertNil(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    // MARK: Helpers
    private func makeSUT(httpClient: HttpClient, storageContext: StorageContext) -> ProductRepository {
        let sut = ProductRepositoryImpl(
            httpClient: httpClient,
            storageContext: storageContext
        )
        
        return sut
    }
}
