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
            ProductAPI(identifier: "", description: "", location: "", imageURL: ""),
            ProductAPI(identifier: "", description: "", location: "", imageURL: "")
        ]
        let sut = makeSUT(withExpectedResult: .success(expectedResult))
        let expectation = XCTestExpectation(description: "Expecting 2 products")
        sut.fetch { result in
            switch result {
            case let .success(products):
                XCTAssertEqual(products.count, 2)
                expectation.fulfill()
            case let .failure(error):
                XCTAssertNil(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    // MARK: Helpers
    private func makeSUT(withExpectedResult result: Result<[ProductAPI], ApiError>) -> ProductRepository {
        let sut = ProductService(httpClient: HttpClientMock<[ProductAPI]>(result: result))
        return sut
    }
}

class HttpClientMock<T: Decodable>: HttpClient {
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