//
//  APIFetcher.swift
//  GroceryAppDemo
//
//  Created by Bhagyesh Desai on 09/12/23.
//

import Foundation

class APIFetcher {
    
    static let shared = APIFetcher()
    
    func fetchAllCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
        guard let url = URL(string: "\(UtilityClass.BASE_URL)/router/get/all/categories") else { return }
        let headers = [
          "Content-Type": "application/json"
        ]
        let request = NSMutableURLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode([CategoryModel].self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchAllItems(with category: String, completion: @escaping (Result<[ItemModel], Error>) -> Void) {
        
        guard let url = URL(string: "\(UtilityClass.BASE_URL)/router/get/category/\(category)") else { return }
        let headers = [
          "Content-Type": "application/json"
        ]
        let request = NSMutableURLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode([ItemModel].self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func makePayment(completion: @escaping (Result<Void, Error>) -> Void) {
        
    }
}
