//
//  HeroesTableViewCellRepresentable.swift
//  marvelHeroesUniverse
//
//  Created by kjoe on 5/15/22.
//

import Foundation
protocol HeroesTableViewCellViewModelRepresentable {
    func thumbnailURl() -> URL?
    
    func heroeName() -> String
    
    func heroeDescription() -> String
    
    func comicNumber() -> String
    
    func seriesNumber() -> String
    
    func storiesNumber() -> String
    
    func eventNumber() -> String
    
    func buttonNumber() -> Int
    
    func titleforButton(at index: Int) -> String
    
    func urlforButtton(at index: Int) -> URL?
}
