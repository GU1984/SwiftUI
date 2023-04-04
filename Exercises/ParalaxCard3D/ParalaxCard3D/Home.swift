//
//  Home.swift
//  ParalaxCard3D
//
//  Created by Георгий Усынин on 04.04.2023.
//

import SwiftUI

struct Home: View {
    
    @State var offset: CGSize = .zero
    
    var body: some View {
        VStack {
            GeometryReader {
                let size = $0.size
                let imageSize = size.width * 0.7
                VStack(alignment: .center) {
                    Image("shoes3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: imageSize)
                        .rotationEffect(.init(degrees: 20))
                        .zIndex(1)
                        .offset(x: 20)
                        .offset(x: offseToAngle().degrees * 5, y: offseToAngle(true).degrees * 5)
                    
                    Text("GEL-NOOSA")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .padding(.top, -20)
                        .padding(.bottom, 40)
                        .zIndex(0)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("ASICS")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .fontWidth(.compressed)
                    
                        HStack {
                            BlendedText("Training Running Shoes")
                            Spacer(minLength: 0)
                            BlendedText("$99")
                        }
                        
                        HStack {
                            BlendedText("YOUR NEXT SHOES")
                           
                            Spacer(minLength: 0)
                           
                            Button {
                                
                            } label: {
                                Text("BUY")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 15)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(Color.pink)
                                            .brightness(-0.1)
                                    }
                            }
                        }
                        .padding(.top, 14)
                        
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35, height: 35)
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 10)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .foregroundColor(.white)
                .padding(.top, 65)
                .padding(.horizontal, 15)
                .frame(width: imageSize)
                .background {
                    ZStack(alignment: .topTrailing) {
                        Rectangle()
                            .fill(Color(.init(red: 1/255, green: 1/150, blue: 1/5, alpha: 1)))
                        Circle()
                            .fill(Color.pink)
                            .frame(width: imageSize, height: imageSize)
                            .scaleEffect(1.2, anchor: .leading)
                            .offset(x: imageSize * 0.3, y: -imageSize * 0.1)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                }
                .rotation3DEffect(offseToAngle(true), axis: (x: -1, y: 0, z: 0))
                .rotation3DEffect(offseToAngle(), axis: (x: 0, y: 1, z: 0))
                .rotation3DEffect(offseToAngle(true) * 0.1, axis: (x: 0, y: 0, z: 1))
                .scaleEffect(0.9)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            offset = value.translation
                        })
                        .onEnded({ _ in
                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.32, blendDuration: 0.32)) {
                                offset = .zero
                            }
                        })
                )
            }
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }

    func offseToAngle(_ isVertical: Bool = false) -> Angle {
        let progress = (isVertical ? offset.height : offset.width) / (isVertical ? screenSize.height : screenSize.width)

        return .init(degrees: progress * 20)
    }

    var screenSize: CGSize = {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        return window.screen.bounds.size
    }()
    
    @ViewBuilder
    func BlendedText(_ text: String) -> some View {
        Text(text)
            .font(.title3)
            .fontWeight(.semibold)
            .fontWidth(.condensed)
            .blendMode(.difference)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
