//
//  FakeEnpdointFactory.swift
//  MarvelHeroesUniverseTests
//
//  Created by kjoe on 5/18/22.
//

import Foundation
@testable import MarvelHeroesUniverse
struct FakeEndpointFactory: EndpointFactory {
    func createEndpoint(query: String?, characterData: CharacterData) -> EndpointProtocol {
        FakeEndpoint(path: "/method/one", method: .get)
    }
}

struct FakeEndpoint: EndpointProtocol {
    var path: String
    
    var queryItems: [URLQueryItem]?
    
    var headers: [String: String]?
    
    var method: HTTPMethod
    
    func urlRequest() throws -> URLRequest {
        return URLRequest(url: self.url!)
    }
    
}
