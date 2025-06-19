//
//  NetworkManager.swift
//  WorldLens
//
//  Created by Banu on 19.06.2025.
//

import Foundation

protocol NetworkManagerInterface {
    func request<T: Decodable> (_ endpoint: Endpoint, completion: @escaping (Swift.Result  <T, Error>) -> Void) -> Void
    
    func getArticles(completion: @escaping (Swift.Result<Response , Error>) -> Void) -> Void
    
    func getBreakingNews(completion: @escaping (Swift.Result<Response , Error>) ->Void) -> Void
    
    func getSearchArticles(completion: @escaping (Swift.Result<Response , Error>) ->Void, searchText: String) -> Void
    
    func getCategoriesArticles(completion: @escaping (Swift.Result<Response , Error>) ->Void, categoriesWord: String) -> Void
}


final class NetworkManager: NetworkManagerInterface {
    static let shared = NetworkManager()
    
    private init() {}
    
    func request<T:Decodable> (_ endpoint : Endpoint, completion : @escaping (Swift.Result  <T, Error>) ->Void) ->Void {
        
        let urlSessionTask = URLSession.shared.dataTask(with: endpoint.request()) {(data ,response , error) in
            if let error = error {
                print(error)
            }
            if let response = response as? HTTPURLResponse {}
            
            if let data = data {
                do {
                    let jsonData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(jsonData))
                    
                }catch let error {
                    completion(.failure(error))
                }
            }
            
        }
        urlSessionTask.resume()
    }
    
    func getArticles (completion: @escaping (Swift.Result<Response , Error>) ->Void) -> Void {
        let endpoint = Endpoint.articles(query: "&apiKey=3981648866734d75902b4b10fc53ff32")
        request(endpoint, completion: completion)
    }
    
    func getBreakingNews (completion: @escaping (Swift.Result<Response , Error>) ->Void) -> Void {
        let endpoint = Endpoint.articles(query: "&apiKey=3981648866734d75902b4b10fc53ff32")
        request(endpoint, completion: completion)
    }
    
    func getSearchArticles (completion: @escaping (Swift.Result<Response , Error>) ->Void, searchText: String) -> Void {
        let endpoint = Endpoint.searchArticles(searchText: searchText)
        request(endpoint, completion: completion)
    }
    
    func getCategoriesArticles  (completion: @escaping (Swift.Result<Response , Error>) ->Void, categoriesWord: String) -> Void {
        let endpoint = Endpoint.categoriesArticles(selectedCategories: categoriesWord)
        request(endpoint, completion: completion)
    }
}

