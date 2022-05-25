//
//  HomeViewControllerTest.swift
//  MarvelHeroesUniverseTests
//
//  Created by kjoe on 5/22/22.
//

import XCTest
@testable import MarvelHeroesUniverse
class HomeViewControllerTest: XCTestCase {
    var sut: HomeViewController!
    var viewModel: FakeHomeViewModel!
    override func setUpWithError() throws {
        let data = loadStubFromBundle(withName: "characterList", extension: "json")
        viewModel = FakeHomeViewModel(data: data)
        sut = HomeViewController(viewModel: viewModel)
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_tableViewDelegates_shouldBeConnected() {
        XCTAssertNotNil(sut.tableView.dataSource, "dataSource")
        XCTAssertNotNil(sut.tableView.delegate, "delegate")
        XCTAssertNotNil(sut.navigationItem.searchController)
    }
    func testNumberOfRowsShouldBe1() {
        XCTAssertEqual(numberOfRows(in: sut.tableView), 1)
    }
    func testCellForRowAtWithRow1ShouldSetCellLabelToTwo() {
        let cell = sut.tableView.dataSource?.tableView(
                sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! HeroesTableViewCell
        XCTAssertEqual(cell.buttonStack.subviews.count, 3)
        XCTAssertEqual(cell.heroeName.text, "3-D Man")
    }
    func testSearchButton() {
        sut.searchController.searchBar.text = "search"
        sut.searchBarSearchButtonClicked(sut.searchController.searchBar)
        XCTAssertEqual(numberOfRows(in: sut.tableView), 2)
    }
    func testSearhCancelButton() {
        sut.searchBarCancelButtonClicked(sut.searchController.searchBar)
        XCTAssertEqual(numberOfRows(in: sut.tableView), 1)
        XCTAssertTrue(sut.searchController.searchBar.text!.isEmpty)
    }
    func test_didEndDisplayingCellRemoveButon() {
        // given
        let cell = HeroesTableViewCell()
        // when
        let indexPath = IndexPath(row: 0, section: 0)
        sut.tableView(UITableView(), didEndDisplaying: cell, forRowAt: indexPath)
        // then
        XCTAssertEqual(cell.buttonStack.subviews.count, 0)
        XCTAssertEqual(cell.cardView.borderWidth, 0)
        XCTAssertEqual(cell.cardView.borderColor, .black)
    }
    func testDidEndDisplayinTotalless10CallForMoreData() {
        // given
        let expec = expectation(description: "closure called")
        let data = loadStubFromBundle(withName: "characterList", extension: "json")
        let viewM: FakeMoreThan2HomeViewModel = FakeMoreThan2HomeViewModel(data: data)
        sut.viewModel = viewM
        let cell = HeroesTableViewCell()
        viewM.reloadClosure = {
            expec.fulfill()
        }
        let indexPath = IndexPath(row: 10, section: 0)
        sut.tableView(UITableView(), didEndDisplaying: cell, forRowAt: indexPath)
        wait(for: [expec], timeout: 1.0)
    }
    func testRelaodlClosureAddTableFooterView() {
         // given
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        window.rootViewController = sut
        window.makeKeyAndVisible()
        // when
        viewModel.reloadClosure?()
        // then
        RunLoop.current.run(until: .now + 2)
        XCTAssertNotNil(sut.tableView.tableFooterView)
    }
}
