//
//  CharacterListEndpointFactory.swift
//  marvelHeroesUniverse
//
//  Created by kjoe on 5/15/22.
//

import Foundation
struct CharacterListEndpointFactory {
    func createEndpoint(query: String? = nil) -> EndpointProtocol {
        let path = "/v1/public/characters"
        var items = [URLQueryItem(name: "apikey", value: apikey)]
        if query != nil {
            items.append(URLQueryItem(name: "name", value: query))
        }
        let headers = ["Content-Type": "application/json"]
        return CharacterListEnpoint(path: path, queryItems: items, headers: headers, method: .get)
    }
}
extension CharacterListEndpointFactory: EndpointFactory { }
