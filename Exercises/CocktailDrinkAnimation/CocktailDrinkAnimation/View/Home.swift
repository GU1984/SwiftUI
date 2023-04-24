//
//  Home.swift
//  CocktailDrinkAnimation
//
//  Created by Георгий Усынин on 20.04.2023.
//

import SwiftUI

struct Home: View {
    
    @State var offsetY: CGFloat = 0
    @State var currentIndex: CGFloat = 0
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            let cardSize = size.width
            
//            LinearGradient(colors: [
//                .clear,
//                Color("bg").opacity(0.2),
//                Color("bg").opacity(0.45),
//                Color("bg")
//            ], startPoint: .top, endPoint: .bottom)
            
            LinearGradient(colors: [
                .clear,
                Color("bg").opacity(0.2),
                Color("bg").opacity(0.45),
                Color("bg")
            ], startPoint: .top, endPoint: .bottom)
            
            
            .frame(height: 300)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
            
            HeaderView()
            
            VStack(spacing: 0) {
                ForEach(drinks) { drink in
                    DrinkView(drink: drink, size: size)
                }
            }
           
            .frame(width: size.width)
            .padding(.top, size.height - cardSize)
            .offset(y: offsetY)
            .offset(y: -currentIndex * cardSize)
        }
        .coordinateSpace(name: "SCROLL")
        .contentShape(Rectangle())
        .gesture(
            DragGesture()
                .onChanged({ value in
                    offsetY = value.translation.height * 0.4
                }).onEnded({ value in
                    let translation = value.translation.height
                    
                    withAnimation(.easeInOut) {
                        
                    if translation > 0 {
                        if currentIndex > 0 && translation > 250 {
                            currentIndex -= 1
                        }
                        } else {
                            if currentIndex < CGFloat(drinks.count - 1 ) && -translation > 250 {
                                currentIndex += 1
                            }
                        }
                        offsetY = .zero
                    }
                })
        )
        .preferredColorScheme(.dark)
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        VStack{
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                }
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "cart")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                }
            }
            
            GeometryReader {
                let size = $0.size
                
                HStack(spacing: 0) {
                    ForEach(drinks) { drink in
                        VStack(spacing: 15) {
                            Text(drink.title)
                                .font(.largeTitle.bold())
                                .multilineTextAlignment(.center)
                            
                            Text(drink.price)
                                .font(.title)
                            
                        }
                        .frame(width: size.width)
                    }
                }
                .offset(x: currentIndex * -size.width)
                .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.8), value: currentIndex)
            }
            .padding(.top, -5)
        }
        .padding(15)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
   ContentView()
    }
}


struct DrinkView: View {
    var drink: Drink
    var size: CGSize
    var body: some View {
        let cardSize = size.width
        let maxCardDisplaySize = size.width * 4
        GeometryReader { proxy in
            let _size = proxy.size
            
            let offset = proxy.frame(in: .named("SCROLL")).minY - (size.height - cardSize)
            let scale = offset <= 0 ? (offset / maxCardDisplaySize) : 0
            let reducedScale = 1 + scale
            let currentCardScale = offset / cardSize
            
            Image(drink.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: _size.width, height: _size.height)
                .scaleEffect(reducedScale < 0 ? 0.001 : reducedScale, anchor: .init(x: 0.5, y: 1 - currentCardScale / 2.4))
                .scaleEffect(offset > 0 ? 1 + currentCardScale : 1, anchor: .top)
                .offset(y: offset > 0 ? currentCardScale * 200 : 0)
                .offset(y: currentCardScale * -130)
        }
        .frame(height: size.width)
    }
}
