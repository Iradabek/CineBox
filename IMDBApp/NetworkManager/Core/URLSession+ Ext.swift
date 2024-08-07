//
//  URLSession+ Ext.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 30.06.24.
//

import UIKit

extension URLSession {
    // MARK: - Reusable Fetch Function
    func fetch<T: Codable>(type: T.Type, url: String, method: HTTPMethods = .GET, headers: [String: String]?, completion: @escaping ((Result<T, Error>) -> Void)) {
        guard let url = URL(string: url) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        /// - Creating request
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        /// - If data exists then decoding data
        let task = dataTask(with: request) { data, _, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NetworkError.invalidData))
                }
                return
            }
            
           //  Print the raw JSON data for debugging
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print("Raw JSON response: \(jsonString)")
//            }
            
            do {
                let jsonResult = try JSONDecoder().decode(T.self, from: data)
                completion(.success(jsonResult))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
