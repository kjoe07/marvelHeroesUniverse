//
//  Response.swift
//  marvelHeroesUniverse
//
//  Created by kjoe on 5/14/22.
//

import Foundation
struct CharactersResponse: Codable {
    let code: Int
    let status: String
    let copyright: String
    let attributionText: String
    let data: CharacterData
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case status = "status"
        case copyright = "copyright"
        case attributionText = "attributionText"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        code = try value.decode(Int.self, forKey: .code)
        status = try value.decode(String.self, forKey: .status)
        copyright = try value.decode(String.self, forKey: .copyright)
        attributionText = try value.decode(String.self, forKey: .attributionText)
        data = try value.decode(CharacterData.self, forKey: .data)
    }
}

