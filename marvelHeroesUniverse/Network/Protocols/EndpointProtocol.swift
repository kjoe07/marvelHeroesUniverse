//
//  EndpointProtocol.swift
//  MarvelHeroesUniverse
//
//  Created by kjoe on 5/14/22.
//

import Foundation
let baseUrl = "gateway.marvel.com"
let apikey = "056da8f52f2d3b6c9296fec5fb17408f"

/// Protocol to create the request to network
///
/// never instantiate this directly use one of the two created or create one as needed
protocol EndpointProtocol {
    /// path for the url the part after last / in the domain and query items in the url in case provided
    var path: String { get set }
    /// queryItems: the part of the url after ? and separated by & sginal enter as [String: Any] dictonary
    var queryItems: [URLQueryItem]? { get set }
    /// headers for the request in case needed
    var headers: [String: String]? { get set }
    /// the method use for the request
    var method: HTTPMethod { get set }
    /// build the full url for the endpoint usgin path and base url
    var url: URL? { get }
    /// get the URl
    /// - Returns: retrn URLRequest from the url in the endpont throws in case invalid value
    func urlRequest() throws -> URLRequest
}
extension EndpointProtocol {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseUrl
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}
