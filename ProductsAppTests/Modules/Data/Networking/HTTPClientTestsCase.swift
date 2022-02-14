//
//  HTTPClientTestsCase.swift
//  ProductsAppTests
//
//  Created by Khoubaib Chamekh on 13/2/2022.
//

import XCTest
@testable import ProductsApp

class HTTPClientTestsCase: XCTestCase {

    func test_InitHttpClientDoesntNeedUrlRequest() {
        let sut: HttpClient = APIClient(httpSession: HTTPSessionSpy())
        XCTAssertNotNil(sut)
    }
    
    func test_InitHttpClientshouldNotMakeACall() {
        let httpSession = HTTPSessionSpy()
        let sut: HttpClient = APIClient(httpSession: httpSession)
        XCTAssertEqual(httpSession.numberOfCalls, 0)
        sut.request(ApiRequest(resource: URL(string: "HTTP://anyURL")!), completion: { (result: Result<[ProductAPI], Error>) in })
        XCTAssertEqual(httpSession.numberOfCalls, 1)
    }
    
    func test_receiveExpectedResult() {
        let expectedResult = [
            FakeProductAPI(identifier: 1, name: "CHANNEL"),
            FakeProductAPI(identifier: 2, name: "DIOR")
        ]
        
        let encoder = JSONEncoder()
        let data = try? encoder.encode(expectedResult)
        let httpSession = HTTPSessionSpy(result: data)
        let sut: HttpClient = APIClient(httpSession: httpSession)
        let expectation = XCTestExpectation(description: "Expecting 2 products")
        sut.request(ApiRequest(resource: URL(string: "HTTP://anyURL")!)) { (result: Result<[FakeProductAPI], Error>) in
            expectation.fulfill()
            switch result {
            case .success(let products):
                XCTAssertEqual(products.count, expectedResult.count)
                products.enumerated().forEach { index, product in
                    XCTAssertEqual(product.identifier, expectedResult[index].identifier)
                    XCTAssertEqual(product.name, expectedResult[index].name)
                }
                
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
}

class HTTPSessionSpy: HTTPSession {
    var numberOfCalls = 0
    private var result: Data?
    
    init(result: Data? = nil) {
        self.result = result
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> HTTPSessionTask {
        numberOfCalls += 1
        completionHandler(
            result,
            HTTPURLResponse(url: URL(string: "HTTP://anyURL")!, statusCode: 200, httpVersion: "", headerFields: nil),
            nil
        )
        
        return HTTPSessionTaskDummy()
    }
}

class HTTPSessionTaskDummy: HTTPSessionTask {
    func resume() {}
}

struct FakeProductAPI: Codable {
    let identifier: Int
    let name: String
}
