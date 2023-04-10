//
//  Tab.swift
//  Deeplinks
//
//  Created by Георгий Усынин on 10.04.2023.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case home = "Home"
    case settings = "Settings"
    case favourite = "Favourites"
    
    var symbolImage: String {
        switch self {
        case .home:
            return "house.fill"
        case.settings:
            return "gear"
        case .favourite:
            return "heart.fill"
        }
    }
    
    static func cnvert(from: String) -> Self? {
        return Tab.allCases.first { tab in
            tab.rawValue.lowercased() == from.lowercased()
        }
    }
    
    
    
}
