//
//  FakeLoader.swift
//  MarvelHeroesUniverseTests
//
//  Created by kjoe on 5/18/22.
//

import Foundation
@testable import MarvelHeroesUniverse
class SuccessFakeLoader: DataLoaderProtocol {
    
    let data: Data
    var loadDataCalled = 0
    var loadDataCalledClosure: ((Int) -> Void)?
    init(data: Data) {
        self.data = data
    }
    
    func loadData(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        completion(.success(data))
        loadDataCalled += 1
        loadDataCalledClosure?(loadDataCalled)
    }
}
class ErrorFakeLoader: DataLoaderProtocol {
    
    var loadDataCalledClosure: ((Int) -> Void)?
    
    func loadData(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        completion(.failure(ServerError.badData))
    }
}

class FakeLoader: DataLoaderProtocol {
    let successFakeLoader: SuccessFakeLoader
    let errorFakeLoader: ErrorFakeLoader
    var error = false
    let data: Data
    var loadDataCalledClosure: ((Int) -> Void)?
    init(data: Data) {
        self.data = data
        successFakeLoader = SuccessFakeLoader(data: data)
        errorFakeLoader = ErrorFakeLoader()
    }
    
    func loadData(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        if error {
            successFakeLoader.loadDataCalledClosure = { value in
                self.loadDataCalledClosure?(value)
            }
            errorFakeLoader.loadData(request: request, completion: completion)
        } else {
            successFakeLoader.loadDataCalledClosure = { value in
                self.loadDataCalledClosure?(value)
            }
            successFakeLoader.loadData(request: request, completion: completion)
        }
    }
}
