//
//  FavouriteStack.swift
//  Deeplinks
//
//  Created by Георгий Усынин on 10.04.2023.
//

import SwiftUI

enum FavouroteStack: String,CaseIterable {
    case iJustin = "iJustin"
    case kavia = "Kavia"
    case jenna = "Jenna"
    
    static func convert(from: String) -> Self? {
        return self.allCases.first { tab in
            tab.rawValue.lowercased() == from.lowercased()
        }
    }
}
