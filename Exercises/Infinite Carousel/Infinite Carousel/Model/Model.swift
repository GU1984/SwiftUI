//
//  Model.swift
//  Infinite Carousel
//
//  Created by Георгий Усынин on 29.03.2023.
//

import SwiftUI

struct Page: Identifiable, Hashable {
    var id: UUID = .init()
    var color: Color
}

struct Page2: Identifiable, Hashable {
    var id: UUID = .init()
    var imageName: String
}
