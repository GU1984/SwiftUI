//
//  Model.swift
//  SpotifyHeader
//
//  Created by Георгий Усынин on 30.03.2023.
//

import SwiftUI


struct Album: Identifiable {
    var id = UUID().uuidString
    var albumName: String
}


var albums: [Album] = [
    Album(albumName: "Kill'em all"),
    Album(albumName: "Ride the Lightning"),
    Album(albumName: "Master of Puppets"),
    Album(albumName: "...And Justice for All"),
    Album(albumName: "Metallica (Black Album)"),
    Album(albumName: "Load"),
    Album(albumName: "Reload"),
    Album(albumName: "St. Anger"),
    Album(albumName: "Death Magnetic"),
    Album(albumName: "Hardwired...To Self-Destruct"),
    Album(albumName: "Reload"),
    Album(albumName: "St. Anger"),
    Album(albumName: "Death Magnetic"),
    Album(albumName: "Hardwired...To Self-Destruct")


]
