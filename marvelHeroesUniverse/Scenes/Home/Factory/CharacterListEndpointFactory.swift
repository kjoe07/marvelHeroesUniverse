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
        let headers = ["Content-Type": "application/json", "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.3 Safari/605.1.15", "Referer": "https://developer.marvel.com/","Origin": "https://developer.marvel.com"]
        return CharacterListEnpoint(path: path, queryItems: items, headers: headers, method: .get)
    }
}
extension CharacterListEndpointFactory: EndpointFactory { }
