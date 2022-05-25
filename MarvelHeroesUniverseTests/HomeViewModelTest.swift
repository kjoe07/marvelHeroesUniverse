//
//  HomeViewModelTest.swift
//  MarvelHeroesUniverseTests
//
//  Created by kjoe on 5/18/22.
//

import XCTest
@testable import MarvelHeroesUniverse
class HomeViewModelTest: XCTestCase {
    var sut: HomeViewModel!
    override func setUpWithError() throws {
        let data = loadStubFromBundle(withName: "characterList", extension: "json")
        sut = HomeViewModel(service: FakeCharacterListService(data: data),
                            factory: FakeEndpointFactory())
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    func testNumberOfItemsIs0withoutCallLoadData() {
        XCTAssertEqual(sut.numberOfItems(), 0)
    }
    func testNumbeOfItemsIsEqual20isFalse() {
        XCTAssertNotEqual(sut.numberOfItems(), 20)
    }
    func testNumberOfItemsEquals20() {
        let expectation = expectation(description: "data loaded")
        sut.reloadClosure = {
            XCTAssertEqual(self.sut.numberOfItems(), 20)
            XCTAssertEqual(self.sut.footerText(), "Data provided by Marvel. © 2022 MARVEL")
            let viewM = self.sut.viewModelfor(index: 0)
            XCTAssertEqual(viewM.heroeName(), "3-D Man")
            expectation.fulfill()
        }
        sut.loadData()
        wait(for: [expectation], timeout: 1.0)
    }

    func testNumberOfItemsEquals20Search() {
        let search = loadStubFromBundle(withName: "searchResult", extension: "json")
        let newSut = HomeViewModel(service: FakeCharacterListService(data: search),
                            factory: FakeEndpointFactory())
        let expectation = expectation(description: "data loaded")
        newSut.reloadClosure = {
            XCTAssertEqual(newSut.numberOfItems(), 1)
            XCTAssertEqual(newSut.footerText(), "Data provided by Marvel. © 2022 MARVEL")
            let viewM = newSut.viewModelfor(index: 0)
            XCTAssertEqual(viewM.heroeName(), "Spider-Woman (Mattie Franklin)")
            expectation.fulfill()
        }
        newSut.loadData(query: "spider")
        wait(for: [expectation], timeout: 1.0)
    }
    func testLoadMoreDataWithGreaterthanTotal() {
        let search = loadStubFromBundle(withName: "allresultSearch", extension: "json")
        let char = try! JSONDecoder().decode(CharactersResponse.self, from: search)
        let newSut = HomeViewModel(service: FakeCharacterListService(data: search),
                                   factory: FakeEndpointFactory(), data: char.data)
        let expectation = expectation(description: "data loaded")
        newSut.errorClosure = { error in
            XCTAssertEqual(error, "No more info provided")
            expectation.fulfill()
        }
        newSut.loadData(query: "spider")
        wait(for: [expectation], timeout: 1.0)
    }
}
