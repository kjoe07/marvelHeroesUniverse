//
//  ServiceProtocol.swift
//  MarvelHeroesUniverse
//
//  Created by kjoe on 5/14/22.
//

import Foundation
protocol ServiceProtocol {
    func getData<T: Codable>(endpoint: EndpointProtocol, completion: @escaping (Result<T, Error>) -> Void)
}
