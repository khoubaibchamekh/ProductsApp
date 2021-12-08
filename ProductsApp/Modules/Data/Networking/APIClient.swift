//
//  APIClient.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 12/8/21.
//

import Foundation

class APIClient: HttpClient {
    func request<T>(_ request: ApiRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        ///builds request
        var urlRequest = URLRequest(url: request.resource)
        urlRequest.allHTTPHeaderFields = request.header
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.json
        urlRequest.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        ///performs request
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                        
            guard error == nil else {
                completion(.failure(ApiError.requestFailed(error: "\(error?.localizedDescription ?? "ERROR")")))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(ApiError.nonHTTPResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(ApiError.dataError))
                return
            }
            
            var json: T?

            do {
                json = try JSONDecoder().decode(T.self, from: data)
            } catch {
                completion(.failure(ApiError.serializationError))
                return
            }

            if response.statusCode != request.expectedCode {
                let responseText: String? = String(data: data, encoding: String.Encoding.utf8)
                completion(.failure(ApiError.requestFailed(error: responseText ?? "ERROR")))
                return
            }

            if let jsonData = json {
                completion(.success(jsonData))
            } else {
                completion(.failure(ApiError.serializationError))
            }
        }
        
        task.resume()
    }
}
