//
//  HeroeDetailsViewModelRepresentable.swift
//  MarvelHeroesUniverse
//
//  Created by kjoe on 5/29/22.
//

import Foundation
protocol HeroeDetailsViewModelRepresentable {
    
    func numberOfSections() -> Int
    
    func numberOfRow(in section: Int) -> Int
    
    func sectionTitle(for index: Int) -> String
    
    func titlefor(row: Int, in section: Int) -> String
    
    func shouldSelectItem(at row: Int, in section: Int) -> Bool
    
    func urlForItem(at row: Int) -> URL?
    
    var  heroeName: String { get }
    
    var heroeDescription: String { get }
    
    var heroeImageUrlString: String { get }
    
    var footerText: String { get }
}
