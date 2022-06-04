//
//  HeroeDetailViewControllerTest.swift
//  MarvelHeroesUniverseTests
//
//  Created by kjoe on 5/29/22.
//

import XCTest
@testable import MarvelHeroesUniverse
class HeroeDetailViewControllerTest: XCTestCase {
    var sut: HeroeDetailsTableViewController!
    let viewModel = FakeHeroeDetailsViewModel()
    
    override func setUpWithError() throws {
        sut = HeroeDetailsTableViewController(viewModel: viewModel)
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testTableViewDelegatesShouldBeConnected() {
        XCTAssertNotNil(sut.tableView.dataSource, "dataSource")
        XCTAssertNotNil(sut.tableView.delegate, "delegate")
        XCTAssertNil(sut.navigationItem.searchController)
    }
    
    func testNumberOfSectionsShoulbe5() {
        XCTAssertEqual(sut.tableView.dataSource?.numberOfSections?(in: sut.tableView), 5)
    }
    
    func testNumberOfRowsShouldBe1() {
        XCTAssertEqual(numberOfRows(in: sut.tableView), 2)
    }
    
    func testCellForRowAtWithRow1ShouldSetCellLabelToTwo() {
        let cell = sut.tableView.dataSource?.tableView(
                sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell!.textLabel!.text, "title")
    }
    
    func testTitleForSection() {
        let title = sut.tableView.dataSource?.tableView?(sut.tableView, titleForHeaderInSection: 0)
        XCTAssertEqual(title, "section")
    }

    func testSelectItemInSection4isTrue() {
        let expectation = expectation(description: "closure called with tap true")
        viewModel.closure = { value in
            XCTAssertEqual(value, 1)
            expectation.fulfill()
        }
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 4))
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testSelectItemInSectionNot4isFalse() {
        let expectation = expectation(description: "closure called with tap false")
        viewModel.closure = { value in
            XCTAssertEqual(value, 0)
            expectation.fulfill()
        }
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 2))
        wait(for: [expectation], timeout: 1.0)
    }
}
