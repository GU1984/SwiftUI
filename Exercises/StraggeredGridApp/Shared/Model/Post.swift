//
//  Post.swift
//  Post
//
//  Created by Георгий Усынин on 22.09.2021.
//

import SwiftUI

struct Post: Identifiable, Hashable {
    var id = UUID().uuidString
    var imageURL: String
}

