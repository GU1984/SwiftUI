//
//  BlurView.swift
//  SuncedCarouselList
//
//  Created by Георгий Усынин on 12.01.2022.
//

import Foundation
import SwiftUI

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
}
