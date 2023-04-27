//
//  ContentView.swift
//  MatchGeometryEffect
//
//  Created by 1 on 14.09.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Home()
                .tabItem { Label("First", systemImage: "phone.fill") }
            
            Home2()
                .tabItem { Label("Second", systemImage: "message") }
            Home3()
                .tabItem { Label("Third", systemImage: "heart.fill") }
            Home4()
                .tabItem { Label("Forth", systemImage: "trash") }
        }
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
