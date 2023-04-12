//
//  Home.swift
//  Shoe3D
//
//  Created by Георгий Усынин on 12.04.2023.
//

import SwiftUI
import SceneKit

struct Home: View {
    
    @State var scene: SCNScene? = .init(named: "sneaker_airforce.scn")
    
    @State var isVerticalLook: Bool = false
    @State var currentSize: String = "8"
    @Namespace var animation
    
    @GestureState var offset: CGFloat = 0
    
    var body: some View {
        VStack {
            HeaderView()
            
            CustomSceneView(scene: $scene)
                .frame(height: 350)
                .padding(.top, -50)
                .padding(.bottom, -15)
                .zIndex(-10)
            
            CustomSeeker()
            
            ShoeProperties()
            
        }
        .padding()
    }
    
    @ViewBuilder
    func ShoeProperties() -> some View {
        VStack {
            VStack(alignment: .leading, spacing: 12) {
                Text("Nike Air Force")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                Text("Men's sneaker")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
                Label {
                    Text("4.5")
                        .fontWeight(.semibold)
                } icon: {
                    Image(systemName: "star.fill")
                    
                }
                .foregroundColor(.yellow)

            }
            .padding(.top, 30)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Size")
                    .font(.title3.bold())
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                    let size = ["7.5", "8",  "8.5", "9", "9.5", "10", "10.5", "11"]
                    ForEach(size, id: \.self) { size in
                    
                            Text(size)
                            .fontWeight(.semibold)
                            .foregroundColor(currentSize == size ? .black : .white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                            .background {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.white.opacity(0.2))
                                    
                                    if currentSize == size {
                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(.white)
                                            .matchedGeometryEffect(id: "TAB", in: animation)
                                    }
                                }
                            }
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    currentSize = size
                                }
                            }
                        }
                    }
                }
            }
            .padding(.top, 20)
            
            HStack(alignment: .top) {
                Button {
                    
                } label: {
                    VStack(spacing: 15) {
                        Image(systemName: "bag.fill")
                            .font(.largeTitle)
                          
                            .frame(width: 45, height: 45)
                            .padding(.top,15)
                            .padding(.horizontal, 15)
                        
                        Text("$149.5")
                            .fontWeight(.semibold)
                            .padding(.bottom, 15)
                            
                           
                        }
                    .foregroundColor(.black)
                    .background {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(.white)
                    }
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("di;obn;wunb ;eirng;oifnbosd wirgnw;oinb")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    Button {
                        
                    } label: {
                        Text("More details")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 10)
                }
                .frame(maxHeight: .infinity, alignment: .leading)
                .padding(.leading, 20)
            }
            .padding(.top, 30)
            
        }
    }
    
    @ViewBuilder
    func CustomSeeker()-> some View  {
        GeometryReader { _ in
            Rectangle()
                .trim(from: 0, to: 0.474)
                .stroke(.linearGradient(colors: [
                    .clear,
                    .clear,
                    .white.opacity(0.2),
                    .white.opacity(0.6),
                    .white,
                    .white.opacity(0.6),
                    .white.opacity(0.2),
                    .clear,
                    .clear
                ], startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round, miterLimit: 1, dash: [3], dashPhase: 1))
                .offset(x: offset)
                .overlay {
                    HStack(spacing: 3) {
                        Image(systemName: "arrowtriangle.left.fill")
                            .font(.caption)
                        
                        
                            Image(systemName: "arrowtriangle.right.fill")
                                .font(.caption)
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 10)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.white)
                    }
                    .offset(y: -12)
                    .offset(x: offset)
                    .gesture(
                    DragGesture()
                        .updating($offset, body: { value, out, _ in
                            out = value.location.x - 20
                        })
                    )
                }
        }
        .frame(height: 20)
        .onChange(of: offset, perform: { newValue in
            rotateObject(animate: offset == .zero)
        })
        .animation(.easeInOut(duration: 0.4), value: offset == .zero)
    }
    
    func rotateObject(animate: Bool = false)  {
        
        if animate {
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.4
        }
        
        let newAngle = Float((offset * .pi) / 180)
        
        if isVerticalLook {
            scene?.rootNode.childNode(withName: "Root", recursively: true)?.eulerAngles.x = newAngle
        } else {
            scene?.rootNode.childNode(withName: "Root", recursively: true)?.eulerAngles.y = newAngle
        }
        if animate {
            SCNTransaction.commit()
        }
    }
    
    
    @ViewBuilder
    func HeaderView() -> some View {
        HStack {
            Button {
                
            } label: {
                Image(systemName: "arrow.left")
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundColor(.white)
                    .frame(width: 42, height: 42)
                    .background {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(.white.opacity(0.2))
                    }
            }
            
            Spacer()
            
            
            Button {
                withAnimation (.easeInOut(duration: 0.2)) {
                    isVerticalLook.toggle()
                }
          
                
            } label: {
                Image(systemName: "arrow.left.and.right.righttriangle.left.righttriangle.right.fill")
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundColor(.white)
                    .rotationEffect(.init(degrees: isVerticalLook ? 0 : 90))
                    .frame(width: 42, height: 42)
                    .background {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(.white.opacity(0.2))
                    }
            }

        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
