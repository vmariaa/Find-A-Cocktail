//
//  ViewController.swift
//  FindACocktail
//
//  Created by Vanda S. on 22/01/2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let favorite = FavoriteDrinks.shared.loadFavourite() else {
            return
        }
        
        FavoriteDrinks.shared.favoritedDrinks = favorite
    }
}
