//
//  ProductRepositoryTestCase.swift
//  ProductsAppTests
//
//  Created by Khoubaib Chamekh on 12/19/21.
//

import XCTest
@testable import ProductsApp

class ProductRepositoryTestCase: XCTestCase {
    func test_fetchProductsWithSuccess() {
        let expectedResult = [
            ProductAPI(
                identifier: 1,
                name: "",
                descriptionText: "",
                price: 100,
                brand: BrandAPI(identifier: "", name: ""),
                isSpecialBrand: true,
                smallImageURL: "",
                largeImageURL: ""
            ),
            ProductAPI(
                identifier: 2,
                name: "",
                descriptionText: "",
                price: 100,
                brand: BrandAPI(identifier: "", name: ""),
                isSpecialBrand: true,
                smallImageURL: "",
                largeImageURL: ""
            )
        ]
        
        let sut = makeSUT(
            httpClient: HttpClientStub<[ProductAPI]>(result: .success(expectedResult)),
            storageContext: StorageContextStub()
        )
        
        let expectation = XCTestExpectation(description: "Expecting 2 products")
        sut.fetch { result in
            expectation.fulfill()
            switch result {
            case let .success(products):
                XCTAssertEqual(products.count, expectedResult.count)
                products.enumerated().forEach { index, product in
                    XCTAssertEqual(product.identifier, expectedResult[index].identifier)
                }
                
            case let .failure(error):
                XCTAssertNil(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_fetchProductsWithoutNetworkButWithCache() {
        let expectedResult = [
            Product(
                identifier: 1,
                name: "",
                descriptionText: "",
                price: 0.0,
                brand: Brand(identifier: "1", name: ""),
                isSpecialBrand: false,
                smallImageURL: "",
                largeImageURL: ""
            ),
            Product(
                identifier: 2,
                name: "",
                descriptionText: "",
                price: 0.0,
                brand: Brand(identifier: "2", name: ""),
                isSpecialBrand: false,
                smallImageURL: "",
                largeImageURL: ""
            )
        ]
        
        let sut = makeSUT(
            httpClient: HttpClientStub<[ProductAPI]>(result: .failure(.dataError)),
            storageContext: StorageContextStub(result: expectedResult)
        )
        
        let expectation = XCTestExpectation(description: "Expecting 2 products")
        sut.fetch { result in
            expectation.fulfill()
            switch result {
            case let .success(products):
                XCTAssertEqual(products.count, expectedResult.count)
                products.enumerated().forEach { index, product in
                    XCTAssertEqual(product.identifier, expectedResult[index].identifier)
                }
                
            case let .failure(error):
                XCTAssertNil(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_fetchProductsWithoutNetworkAndWithoutCache() {
        let expectedResult: ApiError = .dataError
        let sut = makeSUT(
            httpClient: HttpClientStub<[ProductAPI]>(result: .failure(expectedResult)),
            storageContext: StorageContextStub(result: [])
        )
        
        let expectation = XCTestExpectation(description: "Expecting Error")
        sut.fetch { result in
            expectation.fulfill()
            switch result {
            case let .failure(error):
                XCTAssertNotNil(error)
                XCTAssertEqual(error as? ApiError, expectedResult)
                
            default:
                XCTFail("Unexpected result")
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

class HttpClientStub<T: Decodable>: HttpClient {
    private let result: Result<T, ApiError>
    
    init(result: Result<T, ApiError>) {
        self.result = result
    }
    
    func request<T>(_ request: ApiRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        switch result {
        case let .success(response):
            if let response = response as? T {
                completion(.success(response))

            } else {
                completion(.failure(ApiError.dataError))
            }
            
        case let .failure(error):
            completion(.failure(error))
        }
    }
}

class StorageContextStub: StorageContext {
    private let result: [Product]
    init(result: [Product] = []) {
        self.result = result
    }
    
    func fetch<T>(_ model: T.Type, options: FetchOptions?) -> [T] where T : Storable {
        let objects = result.map { $0.mapToPersistenceObject() }
        return objects.compactMap { $0 as? T }
    }
    
    func save<T>(_ objects: [T]) throws where T : Storable {}
}
