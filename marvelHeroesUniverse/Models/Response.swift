//
//  Response.swift
//  MarvelHeroesUniverse
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
}
