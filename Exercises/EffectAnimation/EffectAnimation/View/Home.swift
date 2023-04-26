//
//  Home.swift
//  EffectAnimation
//
//  Created by Георгий Усынин on 26.04.2023.
//

import SwiftUI

struct Home: View {
    
    @State private var isLiked: [Bool] = [false,false,false]
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                CustomButton(systemImage: "suit.heart.fill", status: isLiked[0], activeTint: .pink, inActiveTint: .gray) {
                    isLiked[0].toggle()
                }
                
                CustomButton(systemImage: "star.fill", status: isLiked[1], activeTint: .yellow, inActiveTint: .gray) {
                    isLiked[1].toggle()
                }
                
                CustomButton(systemImage: "square.and.arrow.up.fill", status: isLiked[2], activeTint: .blue, inActiveTint: .gray) {
                    isLiked[2].toggle()
                }
                
            }
        }
    }
    @ViewBuilder
    func CustomButton(systemImage: String, status: Bool, activeTint: Color, inActiveTint: Color, onTap: @escaping () -> ()) -> some View {
        Button(action: onTap) {
            Image(systemName: systemImage)
                .font(.title2)
                .particleEffect(systemImage: systemImage,
                                font: .title2,
                                status: status,
                                activeTint: activeTint,
                                inActiveTint: inActiveTint)
                .foregroundColor(status ?  activeTint : inActiveTint )
                .padding(.horizontal, 18)
                .padding(.vertical, 8)
                .background {
                    Capsule()
                        .fill(status ? activeTint.opacity(0.25) : Color(.darkGray))
                }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
