//
//  Post.swift
//  StrageredGrid
//
//  Created by 1 on 05.04.2023.
//

import SwiftUI

struct Post: Identifiable, Hashable {
    var id = UUID().uuidString
    var imageURL: String
}
