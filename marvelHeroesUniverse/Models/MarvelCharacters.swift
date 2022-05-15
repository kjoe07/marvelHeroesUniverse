//
//  MarvelCharacters.swift
//  marvelHeroesUniverse
//
//  Created by kjoe on 5/14/22.
//

import Foundation
struct MarvelCharacters: Codable {
    let id: String
    let name: String
    let description: String
    let modified: String
    var thumbnail: Thumbnail
    let resourceURI: String
    var comics: [Comic]
    var series: [Serie]
    var stories: [Storie]
    var events: [Event]
    let urls: [Url]
}
