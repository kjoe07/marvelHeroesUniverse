//
//  HeroesTableViewCellViewModelTest.swift
//  MarvelHeroesUniverseTests
//
//  Created by kjoe on 5/26/22.
//

import XCTest
@testable import MarvelHeroesUniverse
class HeroesTableViewCellViewModelTest: XCTestCase {
    
    var sut: HeroesTableViewCellViewModel!
    var heroes: CharactersResponse!
    override func setUpWithError() throws {
        let data = loadStubFromBundle(withName: "searchResult", extension: "json")
        heroes = try! JSONDecoder().decode(CharactersResponse.self, from: data)
        sut = HeroesTableViewCellViewModel(heroe: heroes.data.results.first!)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testHeroeThumnail() {
        XCTAssertNotNil(sut.thumbnailURl)
    }
    
    func testHeroeName() {
        XCTAssertEqual(sut.heroeName(), "Spider-Woman (Mattie Franklin)")
        XCTAssertFalse(sut.heroeName().isEmpty)
    }
    
    func testHeroeDescription() {
        // swiftlint:disable line_length
        let text = """
            Mattie Franklin was granted her powers when, after overhearing a phone call between her father and Norman Osborn about the Gathering of the Five, she took her father's place during the Gathering and was endowed with the awesome powers that Norman Osborn had wanted for himself.
            """
        XCTAssertFalse(sut.heroeDescription().isEmpty)
        XCTAssertEqual(sut.heroeDescription(), text)
    }
    
    func testComicNumber() {
        XCTAssertEqual(sut.comicNumber(), "comics: 16")
    }
    
    func testSeriesNumber() {
        XCTAssertEqual(sut.seriesNumber(), "series: 5")
    }
    
    func testStoriesNumber() {
        XCTAssertEqual(sut.storiesNumber(), "stories: 16")
    }
    
    func testEventNumber() {
        XCTAssertEqual(sut.eventNumber(), "events: 1")
    }
    
    func testButtonNumber() {
        XCTAssertEqual(sut.buttonNumber(), 3)
    }
    
    func testTitleforButton() {
        for ivar in 0..<sut.buttonNumber() {
            XCTAssertFalse(sut.titleforButton(at: ivar).isEmpty)
            XCTAssertEqual(sut.titleforButton(at: ivar), heroes.data.results[0].urls[ivar].type)
        }
    }
    
    func testUrlforButtton() {
        for ivar in 0..<sut.buttonNumber() {
            XCTAssertNotNil(sut.urlforButtton(at: ivar))
        }
    }
    
}
