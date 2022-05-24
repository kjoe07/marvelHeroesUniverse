//
//  ItemsService.swift
//  MarvelHeroesUniverse
//
//  Created by kjoe on 5/14/22.
//

import Foundation
struct CharacterListService: ServiceProtocol {
    
    let loader: DataLoaderProtocol
    
    func getData<T: Codable>(endpoint: EndpointProtocol, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let request = try endpoint.urlRequest()
            loader.loadData(request: request, completion: { result in
                switch result {
                case .success(let data):
                    do {
                        let jsonValue = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(jsonValue))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        } catch {
            completion(.failure(error))
        }
    }
}
