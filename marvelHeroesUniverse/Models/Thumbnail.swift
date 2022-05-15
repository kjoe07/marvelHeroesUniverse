//
//  Thumbnail.swift
//  marvelHeroesUniverse
//
//  Created by kjoe on 5/14/22.
//

import Foundation
struct Thumbnail: Codable {
    let path: String
    let fileExtension: String
    
    enum CodingKeys: String, CodingKey {
        case path = "path"
        case fileExtension = "extension"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        path = try values.decode(String.self, forKey: .path)
        fileExtension = try values.decode(String.self, forKey: .fileExtension)
    }
}
