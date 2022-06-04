//
//  FakeHeroeDetailsViewModel.swift
//  MarvelHeroesUniverseTests
//
//  Created by kjoe on 5/29/22.
//

import Foundation
@testable import MarvelHeroesUniverse
class FakeHeroeDetailsViewModel: HeroeDetailsViewModelRepresentable {
    var heroeName: String = "Name"
    
    var heroeDescription: String = "Description"
    
    var heroeImageUrlString: String = "https://example.com/foto.jpg"
    
    var footerText: String = "FOOTER TEXT"
    
    var shoulSelectNumber = 0
    var closure: ((Int) -> Void)?
    
    func numberOfSections() -> Int {
        5
    }
    
    func numberOfRow(in section: Int) -> Int {
        2
    }
    
    func sectionTitle(for index: Int) -> String {
        "section"
    }
    
    func titlefor(row: Int, in section: Int) -> String {
        "title"
    }
    
    func shouldSelectItem(at row: Int, in section: Int) -> Bool {
        if section == 4 {
            shoulSelectNumber += 1
            closure?(shoulSelectNumber)
            return true
        }
        closure?(0)
        return false
    }
    
    func urlForItem(at row: Int) -> URL? {
        URL(string: "https://example.com")
    }
    
}
