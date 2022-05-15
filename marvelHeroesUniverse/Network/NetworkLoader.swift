//
//  DataLoader.swift
//  marvelHeroesUniverse
//
//  Created by kjoe on 5/14/22.
//

import Foundation
/// DataLoader Implementation
///
/// use URLSession to sent request to the network
struct NetworkLoader: DataLoaderProtocol {
    var session: URLSession
    /// Init
    /// - Parameter session: default value URLSession, provide a custom one to make test ready
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    /// Load Data
    /// - Parameters:
    ///   - request: request URLRequest with all the info needed
    ///   - completion: closure to get the data in the swift Result form with data and error
    func loadData(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
            } else {
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 401 {
                        completion(.failure(ServerError.unAuthorized))
                    } else if response.statusCode >= 200 && response.statusCode <= 209 {
                        guard let data = data else { return }
                        completion(.success(data))
                    } else if response.statusCode >= 500 && response.statusCode <= 599 {
                        completion(.failure(ServerError.serverError))
                    } else {
                        completion(.failure(ServerError.badData))
                    }
                }
            }
        }
        task.resume()
    }
}
