//
//  CharacterData.swift
//  marvelHeroesUniverse
//
//  Created by kjoe on 5/14/22.
//

import Foundation
struct CharacterData: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [MarvelCharacters]
}

