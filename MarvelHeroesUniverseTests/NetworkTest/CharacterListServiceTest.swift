//
//  CharacterListServiceTest.swift
//  MarvelHeroesUniverseTests
//
//  Created by kjoe on 5/18/22.
//

import XCTest
@testable import MarvelHeroesUniverse
class CharacterListServiceTest: XCTestCase {
    var sut: CharacterListService!
    
    override func setUpWithError() throws {
        let data = loadStubFromBundle(withName: "characterList", extension: "json")
        let fakeLoader = FakeLoader(data: data)
        sut = CharacterListService(loader: fakeLoader)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testSutWithSuccessData() {
        let endpoint = CharacterListEndpointFactory().createEndpoint()
        sut.getData(endpoint: endpoint, completion: { (result: Result<CharactersResponse, Error>) in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.code, 200)
            case .failure:
                XCTFail("Unexpected error")
            }
        })
    }
    func testSutWithFailureData() {
        (sut.loader as! FakeLoader).error = true
        let endpoint = CharacterListEndpointFactory().createEndpoint()
        sut.getData(endpoint: endpoint, completion: { (result: Result<CharactersResponse, Error>) in
            switch result {
            case .success:
                XCTFail("Unexpected error")
            case .failure(let error):
                XCTAssertEqual(error as! ServerError, .badData)
            }
        })
    }

}
