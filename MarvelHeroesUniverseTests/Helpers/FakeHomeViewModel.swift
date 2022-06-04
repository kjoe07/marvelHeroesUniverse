//
//  FakeHomeViewModel.swift
//  MarvelHeroesUniverseTests
//
//  Created by kjoe on 5/22/22.
//

import Foundation
@testable import MarvelHeroesUniverse
class FakeHomeViewModel: HomeViewModelRepresentable {
    
    var reloadClosure: (() -> Void)?
    var errorClosure: ((String) -> Void)?
    var heroes: [MarvelCharacters]
    let fullData: [MarvelCharacters]
    let data: Data
    var closure: (() -> Void)?
    var selectIndexCall = 0
    var selectIndexClosure: ((Int) -> Void)?
    var navigateClosure: ((HeroeDetailsViewModelRepresentable) -> Void)?
    
    init(data: Data) {
        self.data = data
        let resp = try! JSONDecoder().decode(CharactersResponse.self, from: data)
        fullData = resp.data.results
        heroes = [fullData[0]]
    }
    
    func numberOfItems() -> Int {
        heroes.count
    }
    
    func viewModelfor(index: Int) -> HeroesTableViewCellViewModelRepresentable {
        return HeroesTableViewCellViewModel(heroe: heroes[0])
    }
    
    func loadData(query: String?) {
        if query != nil {
            heroes.append(fullData[2])
        }
        self.reloadClosure?()
    }
    
    func footerText() -> String {
        "Data provided by Marvel. © 2022 MARVEL"
    }
    
    func select(index: Int) {
        selectIndexCall += 1
        selectIndexClosure?(selectIndexCall)
        navigateClosure?(FakeHeroeDetailsViewModel())
    }
}
class FakeMoreThan2HomeViewModel: HomeViewModelRepresentable {
    var reloadClosure: (() -> Void)?
    var errorClosure: ((String) -> Void)?
    var heroes: [MarvelCharacters]
    let fullData: [MarvelCharacters]
    let data: Data
    var selectIndexCall = 0
    var closure: (() -> Void)?
    var navigateClosure: ((HeroeDetailsViewModelRepresentable) -> Void)?
    var selectIndexClosure: ((Int) -> Void)?
    
    init(data: Data) {
        self.data = data
        let resp = try! JSONDecoder().decode(CharactersResponse.self, from: data)
        fullData = resp.data.results
        heroes = resp.data.results
    }
    
    func numberOfItems() -> Int {
        heroes.count
    }
    
    func viewModelfor(index: Int) -> HeroesTableViewCellViewModelRepresentable {
        return HeroesTableViewCellViewModel(heroe: heroes[0])
    }
    
    func loadData(query: String?) {
        if query != nil {
            heroes.append(fullData[2])
        }
        self.reloadClosure?()
    }
    
    func footerText() -> String {
        "Data provided by Marvel. © 2022 MARVEL"
    }
    
    func select(index: Int) {
        selectIndexCall += 1
        selectIndexClosure?(selectIndexCall)
    }
}
