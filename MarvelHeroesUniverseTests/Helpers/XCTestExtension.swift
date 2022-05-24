//
//  XCTestExtension.swift
//  MarvelHeroesUniverseTests
//
//  Created by kjoe on 5/18/22.
//

import XCTest

extension XCTestCase {
    func loadStubFromBundle(withName name: String, extension: String) -> Data {
        let bundle = Bundle(for: classForCoder)
        let url = bundle.url(forResource: name, withExtension: `extension`)
        return try! Data(contentsOf: url!)
    }
}
