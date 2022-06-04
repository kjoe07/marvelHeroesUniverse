//
//  HeroeDetailsViewModel.swift
//  MarvelHeroesUniverse
//
//  Created by kjoe on 5/29/22.
//

import Foundation
import UIKit
struct HeroeDetailsViewModel {
    
    let heroe: MarvelCharacters
    let attributted: String
    
    func numberOfSections() -> Int {
        return 5
    }
    
    func numberOfRow(in section: Int) -> Int {
        if section == 0 {
            return heroe.comics.returned
        } else if section == 1 {
            return heroe.series.returned
        } else if section == 2 {
            return heroe.stories.returned
        } else if section == 3 {
            return heroe.events.returned
        }
        return heroe.urls.count
    }
    
    func sectionTitle(for index: Int) -> String {
        if index == 0 {
            return "Comics"
        } else if index == 1 {
            return "Series"
        } else if index == 2 {
            return "Stories"
        } else if index == 3 {
            return "Events"
        }
        return "Urls"
    }
    
    func titlefor(row: Int, in section: Int) -> String {
        if section == 0 {
            return heroe.comics.items[row].name
        } else if section == 1 {
            return heroe.series.items[row].name
        } else if section == 2 {
            return heroe.stories.items[row].name
        } else if section == 3 {
            return heroe.events.items[row].name
        }
        return heroe.urls[row].type
    }
    
    func shouldSelectItem(at row: Int, in section: Int) -> Bool {
        return section == 4 ? true : false
    }
    
    func urlForItem(at row: Int) -> URL? {
        if let url = URL(string: heroe.urls[row].url) {
            return url
        }
        return nil
    }
    
    var heroeName: String {
        heroe.name
    }
    
    var heroeDescription: String {
        heroe.description
    }
    
    var heroeImageUrlString: String {
        "\(heroe.thumbnail.path).\(heroe.thumbnail.fileExtension)"
    }
    
    var footerText: String {
        attributted
    }
}
extension HeroeDetailsViewModel: HeroeDetailsViewModelRepresentable {
   
}
