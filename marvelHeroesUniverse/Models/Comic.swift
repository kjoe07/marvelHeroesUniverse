//
//  Comics.swift
//  marvelHeroesUniverse
//
//  Created by kjoe on 5/14/22.
//

import Foundation
struct Comic: Codable  {
    var available: Int
    let collectionURI: String
    var items: [Item]
    var returned: Int
}

