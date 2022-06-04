//
//  HomeViewModel.swift
//  MarvelHeroesUniverse
//
//  Created by kjoe on 5/15/22.
//

import Foundation
import CoreMedia
class HomeViewModel {
    private let service: ServiceProtocol
    private let factory: EndpointFactory
    var reloadClosure: (() -> Void)?
    var errorClosure: ((String) -> Void)?
    private var attributexText: String = ""
    private var characterListData: CharacterData
    private var searchResultData: CharacterData
    private var isSearching = false
    var navigateClosure: ((HeroeDetailsViewModelRepresentable) -> Void)?
    
    init(service: ServiceProtocol, factory: EndpointFactory, data: CharacterData? = nil) {
        self.service = service
        self.factory = factory
        characterListData = data ?? CharacterData(offset: 0, limit: 0, total: 0, count: 0, results: [])
        searchResultData = characterListData
    }
    
    func numberOfItems() -> Int {
        isSearching ? searchResultData.results.count : characterListData.results.count
    }
    
    func viewModelfor(index: Int) -> HeroesTableViewCellViewModelRepresentable {
        let heroe = isSearching ? searchResultData.results[index] : characterListData.results[index]
        return HeroesTableViewCellViewModel(heroe: heroe)
    }
    
    func loadData(query: String? = nil) {
        isSearching = query != nil
        let data = isSearching ? searchResultData : characterListData
        let endpoint = factory.createEndpoint(query: query, characterData: data)
        let offset = isSearching ? searchResultData.offset : characterListData.offset
        let total = isSearching ? searchResultData.total : characterListData.total
        guard  offset == 0 || offset < total else {
            errorClosure?("No more info provided")
            return }
        service.getData(endpoint: endpoint, completion: {[weak self] (result: Result<CharactersResponse, Error>) in
            guard let self = self else {return}
            switch result {
            case .success(let resp):
                if self.isSearching {
                    self.searchResultData.count += resp.data.count
                    self.searchResultData.results.append(contentsOf: resp.data.results)
                } else {
                    self.characterListData.count += resp.data.count
                    self.characterListData.results.append(contentsOf: resp.data.results)
                }
                self.attributexText = resp.attributionText
                self.reloadClosure?()
            case .failure(let error):
                self.errorClosure?(error.localizedDescription)
            }
        })
    }
    func footerText() -> String {
        attributexText
    }
    func select(index: Int) {
        let heroe = isSearching ? searchResultData.results[index] : characterListData.results[index]
        let viewModel = HeroeDetailsViewModel(heroe: heroe, attributted: attributexText)
        navigateClosure?(viewModel)
    }
}
extension HomeViewModel: HomeViewModelRepresentable { }
