//
//  Drink.swift
//  CocktailDrinkAnimation
//
//  Created by Георгий Усынин on 20.04.2023.
//

import SwiftUI


struct Drink: Identifiable {
    var id: UUID = .init()
    var imageName: String
    var title: String
    var price: String
    
}

var drinks: [Drink] = [
    .init(imageName: "ordinary", title: "Foxy lady\nOrdinary drink", price: "$6.99"),
    .init(imageName: "cocktail", title: "Arizona Twister\nCocktail", price: "$7.99"),
    .init(imageName: "popular", title: "Old Fashioned\nCocktail", price: "$5.99"),
    .init(imageName: "homemade", title: "Caribian Liqueur\nHomemade liqueur", price: "$5.99"),
    .init(imageName: "coffee", title: "Jamacian Coffee\nCoffee", price: "$4.99"),
   ]
