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
}
