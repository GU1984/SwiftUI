//
//  Model.swift
//  Deeplinks
//
//  Created by Георгий Усынин on 10.04.2023.
//

import SwiftUI

class AppData: ObservableObject {
    @Published var activeTab: Tab = .home
    @Published var homeNavStack: [HomeStack] = []
    @Published var favouriteNavStack: [FavouroteStack] = []
    @Published var settingsNavStack: [SettingsStack] = []
}
