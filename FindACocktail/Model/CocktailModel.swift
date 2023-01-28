//
//  CocktailModel.swift
//  FindACocktail
//
//  Created by Vanda S. on 26/07/2022.
//

import Foundation

struct Drink: Codable {
    var favorited: Bool?
    let idDrink: String
    let strDrink: String
    var strGlass: String?
    var strInstructions: String?
    var strDrinkThumb: String
    var strIngredient1: String?
    var strMeasure1: String?
    var strIngredient2: String?
    var strMeasure2: String?
    var strIngredient3: String?
    var strMeasure3: String?
    var strIngredient4: String?
    var strMeasure4: String?
    var strIngredient5: String?
    var strMeasure5: String?
    var strIngredient6: String?
    var strMeasure6: String?
    let strIngredient7: String?
    let strMeasure7: String?
    let strIngredient8: String?
    let strMeasure8: String?
    let strIngredient9: String?
    let strMeasure9: String?
    let strIngredient10: String?
    let strMeasure10: String?
    let strIngredient11: String?
    let strMeasure11: String?
    let strIngredient12: String?
    let strMeasure12: String?
    let strIngredient13: String?
    let strMeasure13: String?
    let strIngredient14: String?
    let strMeasure14: String?
    let strIngredient15: String?
    let strMeasure15: String?
}

struct Drinks: Codable {
    var drinks: [Drink]
}




