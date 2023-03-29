//
//  ScrollOffsetModifier.swift
//  AutoScrollTab
//
//  Created by Георгий Усынин on 29.03.2023.
//

import SwiftUI


struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder
    func offsetX(_ addObserver: Bool = false , completion: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                if addObserver {
                    GeometryReader {
                        let rect = $0.frame(in: .global)
                        Color.clear
                            .preference(key: OffsetKey.self, value: rect)
                            .onPreferenceChange(OffsetKey.self, perform: completion)
                    }
                }
        }
    }
    
}
