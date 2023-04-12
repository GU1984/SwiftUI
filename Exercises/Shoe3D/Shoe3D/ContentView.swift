//
//  ContentView.swift
//  Shoe3D
//
//  Created by Георгий Усынин on 12.04.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView(.vertical,showsIndicators: false, content: {
            Home()
        })
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
