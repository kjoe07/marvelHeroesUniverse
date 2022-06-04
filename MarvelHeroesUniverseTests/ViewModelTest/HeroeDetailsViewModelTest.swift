//
//  HeroeDetailsViewModelTest.swift
//  MarvelHeroesUniverseTests
//
//  Created by kjoe on 5/29/22.
//

import XCTest
@testable import MarvelHeroesUniverse
class HeroeDetailsViewModelTest: XCTestCase {

    var sut: HeroeDetailsViewModel!
    override func setUpWithError() throws {
        let data = loadStubFromBundle(withName: "searchResult", extension: "json")
        let hereoResponse = try! JSONDecoder().decode(CharactersResponse.self, from: data)
        
        sut = HeroeDetailsViewModel(heroe: hereoResponse.data.results.first!, attributted: "atrinutted")
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testNumberofSections() {
        XCTAssertEqual(sut.numberOfSections(), 5)
    }
    
    func testNumberOfRowinSections0() {
        XCTAssertEqual(sut.numberOfRow(in: 0), sut.heroe.comics.available)
    }
    
    func testNumberOfRowinSections1() {
        XCTAssertEqual(sut.numberOfRow(in: 1), sut.heroe.series.available)
    }
    
    func testNumberOfRowinSections2() {
        XCTAssertEqual(sut.numberOfRow(in: 2), sut.heroe.stories.available)
    }
    
    func testNumberOfRowinSections3() {
        XCTAssertEqual(sut.numberOfRow(in: 3), sut.heroe.events.available)
    }
    
    func testNumberOfRowinSections4() {
        XCTAssertEqual(sut.numberOfRow(in: 4), sut.heroe.urls.count)
    }
    
    func testTitleForSection0() {
        XCTAssertEqual(sut.sectionTitle(for: 0), "Comics")
    }
    
    func testTitleForSection1() {
        XCTAssertEqual(sut.sectionTitle(for: 1), "Series")
    }
    
    func testTitleForSection2() {
        XCTAssertEqual(sut.sectionTitle(for: 2), "Stories")
    }
    
    func testTitleForSection3() {
        XCTAssertEqual(sut.sectionTitle(for: 3), "Events")
    }
    
    func testTitleForSection4() {
        XCTAssertEqual(sut.sectionTitle(for: 4), "Urls")
    }
    
    func testTitleForRowInSection0() {
        for jvar in 0...4 {
            for ivar in 0..<sut.numberOfRow(in: jvar) {
                let title = sut.titlefor(row: ivar, in: jvar)
                XCTAssertTrue(!title.isEmpty)
            }
        }
    }
    
    func testShouldSelectItemAtSectionNot4() {
        for ivar in 0..<4 {
            for jvar in 0..<sut.numberOfRow(in: ivar) {
                XCTAssertFalse(sut.shouldSelectItem(at: jvar, in: ivar))
            }
        }
    }
    
    func testShouldSelectItemAtSection4ReturnTrue() {
        for ivar in 0..<sut.numberOfRow(in: 4) {
            XCTAssertTrue(sut.shouldSelectItem(at: ivar, in: 4))
        }
    }
    
    func testURLisNotNil() {
        for ivar in 0..<sut.numberOfRow(in: 4) {
            XCTAssertNotNil(sut.urlForItem(at: ivar), "url is nil")
        }
    }
    
    func testURLisNil() {
        let data = loadStubFromBundle(withName: "HeroeDetailNUlLURL", extension: "json")
        let hereoResponse = try! JSONDecoder().decode(CharactersResponse.self, from: data)
        sut = HeroeDetailsViewModel(heroe: hereoResponse.data.results.first!, attributted: "Attributed test")
        for ivar in 0..<sut.numberOfRow(in: 4) {
            XCTAssertNil(sut.urlForItem(at: ivar), "url is not nil")
        }
    }
    func testheroename() {
        XCTAssertFalse(sut.heroeName.isEmpty)
        XCTAssertEqual(sut.heroeName, "Spider-Woman (Mattie Franklin)")
    }
    func testHeroeDescription() {
        // swiftlint:disable line_length
        let descript = "Mattie Franklin was granted her powers when, after overhearing a phone call between her father and Norman Osborn about the Gathering of the Five, she took her father's place during the Gathering and was endowed with the awesome powers that Norman Osborn had wanted for himself."
        XCTAssertEqual(sut.heroeDescription, descript)
    }
    func testFooterTest() {
        XCTAssertEqual(sut.footerText, "atrinutted")
    }
    
    func testHeroeImageURlString() {
        let urlstring = sut.heroeImageUrlString
        let string = "http://i.annihil.us/u/prod/marvel/i/mg/2/30/531771c2ab020.jpg"
        XCTAssertEqual(urlstring, string)
        XCTAssertNotNil(URL(string: urlstring))
    }
}
