//
//  FakeHeroesTableViewCellRepresentable.swift
//  MarvelHeroesUniverseTests
//
//  Created by kjoe on 5/24/22.
//

import Foundation
@testable import MarvelHeroesUniverse
struct FakeHeroesTableViewCellViewModel: HeroesTableViewCellViewModelRepresentable {
    func thumbnailURl() -> URL? {
        URL(string: "https://example.com/image.png")
    }
    
    func heroeName() -> String {
        "Spider Man"
    }
    
    func heroeDescription() -> String {
        ""
    }
    
    func comicNumber() -> String {
        "1254789"
    }
    
    func seriesNumber() -> String {
        "325"
    }
    
    func storiesNumber() -> String {
        "0"
    }
    
    func eventNumber() -> String {
        "1"
    }
    
    func buttonNumber() -> Int {
        3
    }
    
    func titleforButton(at index: Int) -> String {
        "button"
    }
    
    func urlforButtton(at index: Int) -> URL? {
        URL(string: "https://google.com/search?")
    }
}
