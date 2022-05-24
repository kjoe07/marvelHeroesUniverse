//
//  ServerError.swift
//  MarvelHeroesUniverse
//
//  Created by kjoe on 5/14/22.
//

import Foundation
enum ServerError: Error, LocalizedError {
    /// The request was invalid and couldn't be completed.
    case invalidRequest
    /// the data recived is not correct
    case badData
    /// the user is not authorized to see the content
    case unAuthorized
    /// the id is empyt
    case emptyId
    case serverError
    case invalidURL
    case nullHeaders
    /// errror Description
    ///
    /// localized response from the current error in human readable format
    public var errorDescription: String? {
        switch self {
        case .invalidRequest:
            return "Could not make the request because the URL was malformed"
        case .badData:
            return "the Data provided is not in the right format please contact support"
        case .unAuthorized:
            return "you dont have access to the resource"
        case .emptyId:
            return "the id for the requested action could no be an empty string please use a valid string id"
        case .serverError:
            return "Internal server error"
        case .invalidURL:
            return "the url for the resource is not valid"
        case .nullHeaders:
            return "the headers are null, please add the required headers"
        }
    }
}
