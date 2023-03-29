//
//  Main.swift
//  AutoScrollTab
//
//  Created by Георгий Усынин on 29.03.2023.
//

import SwiftUI

struct Main: View {
    
    @State private var activeTab: Tab = .animal
    @State private var scrollProgress: CGFloat = .zero
    @State private var tapState: AnimationState = .init()
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            VStack{
                
                TabIndicatorView()
                
                TabView(selection: $activeTab) {
                    ForEach(Tab.allCases, id:\.rawValue) { tab in
                        TabImageView(tab)
                            .tag(tab)
                            .offsetX(activeTab == tab) { rect in
                                let minX = rect.minX
                                let pageOffset = minX - (size.width * CGFloat(tab.index))
                                let pageProgress = pageOffset / size.width
                                if !tapState.status {
                                    scrollProgress = max(min(pageProgress, 0), -CGFloat(Tab.allCases.count - 1))
                                }
                            }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .ignoresSafeArea(.container, edges: .bottom)
        }
    }
    
    @ViewBuilder
    func TabIndicatorView() -> some View {
        GeometryReader {
            let size = $0.size
            
            let tabWidth = size.width / 3
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Text(tab.rawValue)
                        .font(.title3.bold())
                        .frame(width: tabWidth)
                        .foregroundColor(activeTab == tab ? .primary : .gray)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                activeTab = tab
                                scrollProgress = -CGFloat(tab.index)
                                tapState.startAnimation()
                            }
                        }
                }
            }
            .modifier(
                AnimationEndCallback(endValue: tapState.progress, onEnd: {
                    tapState.reset()
                })
            )
            .frame(width: CGFloat(Tab.allCases.count) * tabWidth)
            .padding(.leading, tabWidth)
            .offset(x: scrollProgress * tabWidth)
        }
        .frame(height: 50)
        .padding(.top, 15)
    }
    
    @ViewBuilder
    func TabImageView(_ tab: Tab) -> some View {
        GeometryReader {
            let size = $0.size
            
            Image(tab.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
                .clipped()

        }
        .ignoresSafeArea(.container, edges: .bottom)
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
