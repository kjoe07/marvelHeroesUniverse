//
//  HomeViewModelRepresentable.swift
//  MarvelHeroesUniverse
//
//  Created by kjoe on 5/15/22.
//

import Foundation
protocol HomeViewModelRepresentable {
    func numberOfItems() -> Int
    
    func viewModelfor(index: Int) -> HeroesTableViewCellViewModelRepresentable
    
    func loadData(query: String?)
    
    func footerText() -> String
    
    func select(index: Int)
    
    var reloadClosure: (() -> Void)? { get set }    
    var errorClosure: ((String) -> Void)? { get set }
    
}
