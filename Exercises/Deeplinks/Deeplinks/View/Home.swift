//
//  Home.swift
//  Deeplinks
//
//  Created by Георгий Усынин on 10.04.2023.
//

import SwiftUI

struct Home: View {
    
    @EnvironmentObject private var appData: AppData
    
    var body: some View {
        TabView(selection: $appData.activeTab) {
            HomeView()
                .tag(Tab.home)
                .tabItem {
                    Image(systemName: Tab.home.symbolImage)
                }
            
            FavouriteView()
                .tag(Tab.favourite)
                .tabItem {
                    Image(systemName: Tab.favourite.symbolImage)
                }
            
            SettingsView()
                .tag(Tab.settings)
                .tabItem {
                    Image(systemName: Tab.settings.symbolImage)
                }
        }
        .tint(.red)
    }
    @ViewBuilder
    func HomeView() -> some View {
        NavigationStack(path: $appData.homeNavStack)  {
            List {
                ForEach(HomeStack.allCases, id: \.rawValue) { link in
                    NavigationLink(value: link) {
                        Text(link.rawValue)
                    }
                }
                
            }
            .navigationTitle("Home")
            .navigationDestination(for: HomeStack.self) { link in
                Text(link.rawValue + "View")
            }
        }
    }
    
    @ViewBuilder
    func FavouriteView() -> some View {
        NavigationStack(path: $appData.favouriteNavStack) {
            List {
                ForEach(FavouroteStack.allCases, id: \.rawValue) { link in
                    NavigationLink(value: link) {
                        Text(link.rawValue)
                    }
                }
                
            }
            .navigationTitle("Favourites")
            .navigationDestination(for: FavouroteStack.self) { link in
                Text(link.rawValue + "View")
            }
        }
    }
    
    func SettingsView() -> some View {
        NavigationStack(path: $appData.settingsNavStack)  {
            List {
                ForEach(SettingsStack.allCases, id: \.rawValue) { link in
                    NavigationLink(value: link) {
                        Text(link.rawValue)
                    }
                }
                
            }
            .navigationTitle("Settings")
            .navigationDestination(for: SettingsStack.self) { link in
                Text(link.rawValue + "View")
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppData())
    }
}
