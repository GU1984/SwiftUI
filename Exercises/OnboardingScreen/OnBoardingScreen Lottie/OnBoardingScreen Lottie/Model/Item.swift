//
//  Item.swift
//  OnBoardingScreen Lottie
//
//  Created by Георгий Усынин on 05.04.2023.
//

import SwiftUI
import Lottie


struct Item: Identifiable, Equatable {
    var id: UUID = .init()
    var title: String
    var subTitle: String
    var lottieView: LottieAnimationView = .init()
}
