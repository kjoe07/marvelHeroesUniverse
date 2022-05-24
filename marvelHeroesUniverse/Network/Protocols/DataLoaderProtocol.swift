//
//  DataLoaderProtocolswift.swift
//  MarvelHeroesUniverse
//
//  Created by kjoe on 5/14/22.
//

import Foundation
protocol DataLoaderProtocol {
    /// Load Data from external Source
    /// - Parameters:
    ///   - request: the urlRequest to get data
    ///   - completion: closure to returns data or error
    func loadData(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void)
}
