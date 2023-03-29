//
//  ContentView.swift
//  Scene
//
//  Created by Георгий Усынин on 07.02.2022.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    var body: some View {
        VStack {
            SceneView(scene: SCNScene(named: "Maven.usdz"), options: [.autoenablesDefaultLighting, .allowsCameraControl])
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
