//
//  MockTableview.swift
//  MarvelHeroesUniverseTests
//
//  Created by kjoe on 5/26/22.
//

import UIKit
class TableViewMock: UITableView {
    
    var dequeueReusableCellCalls: [String: Int] = [:]
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        var numberOfCalls = dequeueReusableCellCalls[identifier] ?? 0
        numberOfCalls += 1
        dequeueReusableCellCalls[identifier] = numberOfCalls        
        return UITableViewCell()
    }
    
}
