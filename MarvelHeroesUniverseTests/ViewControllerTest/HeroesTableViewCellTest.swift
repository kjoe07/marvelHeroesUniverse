//
//  HeroesTableViewCellTest.swift
//  MarvelHeroesUniverseTests
//
//  Created by kjoe on 5/24/22.
//

import XCTest
@testable import MarvelHeroesUniverse
class HeroesTableViewCellTest: XCTestCase {
    var sut: HeroesTableViewCell!
    let viewC = UIViewController()
    override func setUpWithError() throws {
        sut = HeroesTableViewCell()
        let viewModel = FakeHeroesTableViewCellViewModel()
        sut.viewModel = viewModel
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        window.rootViewController = viewC
        window.makeKeyAndVisible()
        // sut.window = window
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    func testActionHandler() {
        let action = sut.actionClosure(identifier: 0)
        let button = UIButton(frame: .zero)
        button.addAction(UIAction(title: "title", handler: action), for: .primaryActionTriggered)
        button.sendActions(for: .primaryActionTriggered)
        RunLoop.current.run(until: .now + 1)
        XCTAssertNotEqual(UIApplication.shared.applicationState, UIApplication.State.active)
    }
}
