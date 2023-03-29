//
//  Post.swift
//  SuncedCarouselList
//
//  Created by Георгий Усынин on 12.01.2022.
//

import Foundation


struct Post: Identifiable, Hashable {
    var id = UUID().uuidString
    var postImage: String
}


let staticData : [Post]  = [
    Post(postImage: "Atlas_V_401"),
    Post(postImage: "Cassini"),
    Post(postImage: "Delta_II"),
    Post(postImage: "DSN_34M_BWG"),
    Post(postImage: "Europa_Clipper"),
    Post(postImage: "GRACE-FO"),
    Post(postImage: "Ingenuity_v3"),
    Post(postImage: "ISS_stationary"),
    Post(postImage: "MarCO"),
    Post(postImage: "MRO"),
    Post(postImage: "New_Horizons"),
    Post(postImage: "Voyager")
    
    ]
