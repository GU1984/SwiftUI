//
//  DeeplinksApp.swift
//  Deeplinks
//
//  Created by Георгий Усынин on 10.04.2023.
//

import SwiftUI

@main
struct DeeplinksApp: App {
    
    @StateObject private var appData: AppData = .init()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appData)
                .onOpenURL { url in
                    let string = url.absoluteString.replacingOccurrences(of: "myapp://", with: "")
                    
                    let components = string.components(separatedBy: "?")
                   
                    for component in components {
                        if component.contains("tab=") {
                            let tabRawValue = component.replacingOccurrences(of: "tab=", with: "")
                            if let requestedTab = Tab.cnvert(from: tabRawValue) {
                                appData.activeTab = requestedTab
                            }
                        }
                        if component.contains("nav=") && string.contains("tab") {
                            let requestedNavPath = component
                                .replacingOccurrences(of: "nav=", with: "")
                                .replacingOccurrences(of: "_", with: " ")
                            
                            switch appData.activeTab {
                            case .home:
                                if let navPath = HomeStack.convert(from: requestedNavPath) {
                                    appData.homeNavStack.append(navPath)
                                }
                            case .favourite:
                                if let navPath = FavouroteStack.convert(from: requestedNavPath) {
                                    appData.favouriteNavStack.append(navPath)
                                }
                            case .settings:
                                if let navPath = SettingsStack.convert(from: requestedNavPath) {
                                    appData.settingsNavStack.append(navPath)
                                }
                            }
                        }
                    }
                }
        }
    }
}
