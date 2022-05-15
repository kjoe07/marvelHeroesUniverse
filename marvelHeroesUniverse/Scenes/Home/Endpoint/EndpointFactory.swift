//
//  EndpointFactory.swift
//  marvelHeroesUniverse
//
//  Created by kjoe on 5/15/22.
//

import Foundation
protocol EndpointFactory {
    func createEndpoint(query: String?) -> EndpointProtocol
}
