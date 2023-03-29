//
//  Tab.swift
//  AutoScrollTab
//
//  Created by Георгий Усынин on 29.03.2023.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case animal = "Animal"
    case butterfly = "Butterfly"
    case forest = "Forest"
    case nature = "Nature"
    case tree = "Tree"
    case lake = "Lake"
    case river = "River"
    case beach = "Beach"
    
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
    
    var count: Int {
        return Tab.allCases.count
    }
}
