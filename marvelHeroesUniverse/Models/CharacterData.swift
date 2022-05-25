//
//  CharacterData.swift
//  MarvelHeroesUniverse
//
//  Created by kjoe on 5/14/22.
//

import Foundation
struct CharacterData: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    var count: Int
    var results: [MarvelCharacters]
}
