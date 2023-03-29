//
//  PageControl.swift
//  Infinite Carousel
//
//  Created by Георгий Усынин on 29.03.2023.
//

import SwiftUI

struct PageControl: UIViewRepresentable {
    var totalPages: Int
    var currentPAge: Int
    
    
    func makeUIView(context: Context) -> UIPageControl{
        let control = UIPageControl()
        control.numberOfPages = totalPages
        control.currentPage = currentPAge
        control.backgroundStyle = .prominent
        control.pageIndicatorTintColor = .gray
        control.currentPageIndicatorTintColor = .blue
        control.allowsContinuousInteraction = false
        
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.numberOfPages = totalPages
        uiView.currentPage = currentPAge
    }
}
