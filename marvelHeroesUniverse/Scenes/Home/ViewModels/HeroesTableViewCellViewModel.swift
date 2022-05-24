//
//  HeroesTableViewCellViewModel.swift
//  MarvelHeroesUniverse
//
//  Created by kjoe on 5/15/22.
//

import Foundation
struct HeroesTableViewCellViewModel {
    
    private let heroe: MarvelCharacters
    
    init(heroe: MarvelCharacters) {
        self.heroe = heroe
    }
    
    func thumbnailURl() -> URL? {
        let string = "\(heroe.thumbnail.path).\(heroe.thumbnail.fileExtension)"
        let component = URLComponents(string: string)      
        return component?.url
    }
    
    func heroeName() -> String {
        heroe.name
    }
    
    func heroeDescription() -> String {
        heroe.description
    }
    
    func comicNumber() -> String {
        "comics: \(heroe.comics.available)"
    }
    
    func seriesNumber() -> String {
        "series: \(heroe.series.available)"
    }
    
    func storiesNumber() -> String {
        "stories: \(heroe.stories.available)"
    }
    
    func eventNumber() -> String {
        "events: \(heroe.events.available)"
    }
    
    func buttonNumber() -> Int {
        heroe.urls.count
    }
    
    func titleforButton(at index: Int) -> String {
        heroe.urls[index].type
    }
    
    func urlforButtton(at index: Int) -> URL? {
        let component = URLComponents(string: heroe.urls[index].url)
        return component?.url
    }
    
}
extension HeroesTableViewCellViewModel: HeroesTableViewCellViewModelRepresentable { }
