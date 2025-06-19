//
//  Endpoint.swift
//  WorldLens
//
//  Created by Banu on 19.06.2025.
//

import Foundation

enum Endpoint {
    case articles(query: String)
    case breakingNews(query: String)
    case searchArticles(searchText: String)
    case categoriesArticles(selectedCategories: String)
}

enum HttpMethod: String {
    case get = "GET"
}

protocol EndpointProtocol {
    var baseUrl: String {get}
    var path : String {get}
    func request () -> URLRequest
}

extension Endpoint: EndpointProtocol {
    var baseUrl: String {
        "https://newsapi.org/v2/"
    }
    
    var path: String {
        switch self {
        case .articles(let query):
            return "everything?q=trump\(query)"
        case .breakingNews(let query):
            return "top-headlines?country=us\(query)"
        case .searchArticles(let searchText):
            return "top-headlines?q=\(searchText)&apiKey=3981648866734d75902b4b10fc53ff32"
        case .categoriesArticles(let selectedCategories):
            return "top-headlines?category=\(selectedCategories)&apiKey=3981648866734d75902b4b10fc53ff32"
        }
    }
    
    var method: HttpMethod {
        .get
    }
    
    func request() -> URLRequest {
        guard var component = URLComponents(string: baseUrl) else {
            fatalError("Invalid Error")
        }
        component.path = path
        var request = URLRequest(url: URL(string: baseUrl+path)!)
        request.httpMethod = method.rawValue
        return request
    }
}

// https://newsapi.org/v2/top-headlines?category=business&apiKey=3981648866734d75902b4b10fc53ff32
//https://newsapi.org/v2/top-headlines?category=Entertainment&apiKey=3981648866734d75902b4b10fc53ff32

