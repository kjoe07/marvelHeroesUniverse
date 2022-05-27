//
//  FakeService.swift
//  MarvelHeroesUniverseTests
//
//  Created by kjoe on 5/18/22.
//

import Foundation
@testable import MarvelHeroesUniverse
class FakeSuscessCharacterListService: ServiceProtocol {
    
    let data: Data
    
    init(data: Data) {
        self.data = data
    }
    
    func getData<T>(endpoint: EndpointProtocol, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable, T: Encodable {
        let response = try! JSONDecoder().decode(T.self, from: data)
        completion(.success(response))
    }
}

class FakeFailureCharacterListService: ServiceProtocol {
    func getData<T>(endpoint: EndpointProtocol, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable, T: Encodable {
        completion(.failure(ServerError.badData))
    }
}

class FakeCharacterListService: ServiceProtocol {
    let successService: FakeSuscessCharacterListService
    let failureService: FakeFailureCharacterListService
    var failure: Bool
    
    init(data: Data, failure: Bool = false) {
        self.failure = failure
        successService = FakeSuscessCharacterListService(data: data)
        failureService = FakeFailureCharacterListService()
    }
    
    func getData<T>(endpoint: EndpointProtocol, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable, T: Encodable {
        if failure {
            failureService.getData(endpoint: endpoint, completion: completion)
        } else {
            successService.getData(endpoint: endpoint, completion: completion)
        }
    }
}
