//
//  HomeViewModel.swift
//  MarvelHeroesUniverse
//
//  Created by kjoe on 5/15/22.
//

import Foundation
class HomeViewModel {
    private let service: ServiceProtocol
    private let factory: EndpointFactory
    var reloadClosure: (() -> Void)?
    private var attributexText: String = ""
    private var characterListData: CharacterData!
    
    init(service: ServiceProtocol, factory: EndpointFactory) {
        self.service = service
        self.factory = factory
    }
    
    func numberOfItems() -> Int {
        return characterListData != nil ? characterListData.results.count : 0
    }
    
    func viewModelfor(index: Int) -> HeroesTableViewCellViewModelRepresentable {
        return HeroesTableViewCellViewModel(heroe: characterListData.results[index])
    }
    
    func loadData(query: String? = nil) {
        let endpoint = factory.createEndpoint(query: query)
        service.getData(endpoint: endpoint, completion: {[weak self] (result: Result<CharactersResponse, Error>) in
            guard let self = self else {return}
            switch result {
            case .success(let resp):
                self.characterListData = resp.data
                self.attributexText = resp.attributionText
                self.reloadClosure?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func footerText() -> String {
        attributexText
    }
}
extension HomeViewModel: HomeViewModelRepresentable { }
