//
//  CharacterListEndpoint.swift
//  MarvelHeroesUniverse
//
//  Created by kjoe on 5/15/22.
//

import Foundation
struct CharacterListEnpoint: EndpointProtocol {
    var path: String
    
    var queryItems: [URLQueryItem]?
    
    var headers: [String: String]?
    
    var method: HTTPMethod
    
    func urlRequest() throws -> URLRequest {
        guard let url = self.url else { throw ServerError.invalidURL }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        guard let headers = headers else { throw ServerError.nullHeaders }
        request.allHTTPHeaderFields = headers
        return request
    }    
}
