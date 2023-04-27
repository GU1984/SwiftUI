//
//  Model.swift
//  MatchGeometryEffect
//
//  Created by 1 on 14.09.2022.
//

import SwiftUI


struct Profile: Identifiable {
    
    var id = UUID().uuidString
    var category: String
    var name: String
    
    var profilePicture: String
}

var profiles = [
    Profile(category: "Launch", name: "Atlas-V 551", profilePicture: "pic8"),
    Profile(category: "Launch", name: "Atlas-V 541", profilePicture: "pic5"),
    Profile(category: "Launch", name: "Delta-II", profilePicture: "pic4"),
    Profile(category: "Solar system", name: "Cassini", profilePicture: "pic2"),
    Profile(category: "MARS - Red Planet", name: "Curiossity", profilePicture: "pic3"),
    Profile(category: "Deep Space network", name: "DSN-70", profilePicture: "pic6"),
    Profile(category: "Deep Space network", name: "DSN-35", profilePicture: "pic7")
]
