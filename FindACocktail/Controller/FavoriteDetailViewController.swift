//
//  FavoriteDetailViewController.swift
//  FindACocktail
//
//  Created by Vanda S. on 25/01/2023.
//

import UIKit

class FavoriteDetailViewController: UIViewController {

    var displayedDrink: Drink?
    var ingredients: [Dictionary<String?, String?>] = []
    var isContentMissing: Bool = false
    
    let detailImageView = UIImageView()
    let detailNameLabel = UILabel()
    let detailGlassLabel = UILabel()
    let detailInstructionsLabel = UILabel()
    let detailInstructions = UITextView()
    let detailIngredientsLabel = UILabel()
    let detailIngredients = UITextView()
    var scrollView = UIScrollView()
    let bottomView = UIView()
    var addToFavoritesButton: UIBarButtonItem?
    
    override func viewWillAppear(_ animated: Bool) {

       displayedDrink = DetailScreenConfig.shared.checkForFavorite(displayedDrink: displayedDrink, addToFavoritesButton: addToFavoritesButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredients = [[displayedDrink?.strIngredient1:displayedDrink?.strMeasure1],
                       [displayedDrink?.strIngredient2:displayedDrink?.strMeasure2],
                       [displayedDrink?.strIngredient3:displayedDrink?.strMeasure3],
                       [displayedDrink?.strIngredient4:displayedDrink?.strMeasure4],
                       [displayedDrink?.strIngredient5:displayedDrink?.strMeasure5],
                       [displayedDrink?.strIngredient6:displayedDrink?.strMeasure6],
                       [displayedDrink?.strIngredient7:displayedDrink?.strMeasure7],
                       [displayedDrink?.strIngredient8:displayedDrink?.strMeasure8],
                       [displayedDrink?.strIngredient9:displayedDrink?.strMeasure9],
                       [displayedDrink?.strIngredient10:displayedDrink?.strMeasure10],
                       [displayedDrink?.strIngredient11:displayedDrink?.strMeasure11],
                       [displayedDrink?.strIngredient12:displayedDrink?.strMeasure12],
                       [displayedDrink?.strIngredient13:displayedDrink?.strMeasure13],
                       [displayedDrink?.strIngredient14:displayedDrink?.strMeasure14],
                       [displayedDrink?.strIngredient15:displayedDrink?.strMeasure15]]
        
        setRightBarButton()
        setScreen()
        
        fetchImage()
    }

    
    
    
    func fetchImage() {
        let indicator = UIActivityIndicatorView()
        view.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: detailImageView.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: detailImageView.centerYAnchor).isActive = true
        indicator.startAnimating()
        guard let url = URL(string: displayedDrink!.strDrinkThumb) else {
            return
        }
        getImage(url: url) { [weak self] image in
            DispatchQueue.main.async {
                indicator.stopAnimating()
                self?.detailImageView.image = image
            }
        }
    }
    
    
    
    func setScreen() {
        DetailScreenConfig.shared.setScrollView(scrollView: scrollView, view: view)
        DetailScreenConfig.shared.setImageView(scrollView: scrollView, imageView: detailImageView, view: view)
        DetailScreenConfig.shared.setNameLabel(scrollView: scrollView, detailNameLabel: detailNameLabel, imageView: detailImageView, view: view, chosenDrink: displayedDrink)
        DetailScreenConfig.shared.setView(scrollView: scrollView, bottomView: bottomView, view: view, detailNameLabel: detailNameLabel)
        DetailScreenConfig.shared.setGlassLabel(scrollView: scrollView, detailGlassLabel: detailGlassLabel, detailNameLabel: detailNameLabel, chosenDrink: displayedDrink, view: view)
        DetailScreenConfig.shared.setIngredientsLabel(scrollView: scrollView, detailIngredientsLabel: detailIngredientsLabel, view: view, detailGlassLabel: detailGlassLabel)
        isContentMissing = DetailScreenConfig.shared.setIngredients(scrollView: scrollView, detailIngredients: detailIngredients, detailIngredientsLabel: detailIngredientsLabel, view: view, ingredients: ingredients, isContentMissing: isContentMissing)
        DetailScreenConfig.shared.setInstructionsLabel(scrollView: scrollView, detailInstructionsLabel: detailInstructionsLabel, view: view, detailIngredients: detailIngredients)
        isContentMissing = DetailScreenConfig.shared.setInstructions(scrollView: scrollView, detailInstructions: detailInstructions, detailInstructionsLabel: detailInstructionsLabel, view: view, chosenDrink: displayedDrink, isContentMissing: isContentMissing)
        DetailScreenConfig.shared.missingContentCheck(isContentMissing: isContentMissing, bottomView: bottomView, scrollView: scrollView, view: view)
    }
    
    func setRightBarButton() {
        if displayedDrink?.favorited != nil {
            addToFavoritesButton = UIBarButtonItem(title: "Remove from favorites", style: .done, target: self, action: #selector(addToFavorites))
        } else {
            addToFavoritesButton = UIBarButtonItem(title: "Add to favorites", style: .done, target: self, action: #selector(addToFavorites))
        }
        navigationItem.rightBarButtonItem = addToFavoritesButton
    }

    @objc func addToFavorites() {
        for drink in FavoriteDrinks.shared.favoritedDrinks {
            if displayedDrink?.idDrink == drink.idDrink {
                if let index:Int = FavoriteDrinks.shared.favoritedDrinks.firstIndex(where: {$0.idDrink == drink.idDrink}) {
                    FavoriteDrinks.shared.favoritedDrinks.remove(at: index)
                    FavoriteDrinks.shared.saveFavourite(FavoriteDrinks.shared.favoritedDrinks)
                    addToFavoritesButton?.title = "Add to favorites"
                    return
                }
            }
        }
        displayedDrink?.favorited = true
        FavoriteDrinks.shared.favoritedDrinks.append(displayedDrink!)
        FavoriteDrinks.shared.favoritedDrinks.sort(by: { $0.strDrink < $1.strDrink })
        FavoriteDrinks.shared.saveFavourite(FavoriteDrinks.shared.favoritedDrinks)
        addToFavoritesButton?.title = "Remove from favorites"
        
    }
    
}
