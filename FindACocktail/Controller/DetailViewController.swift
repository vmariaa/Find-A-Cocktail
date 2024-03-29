//
//  DetailViewController.swift
//  FindACocktail
//
//  Created by Vanda S. on 26/07/2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var chosenDrink: Drink?
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
       chosenDrink = DetailScreenConfig.shared.checkForFavorite(displayedDrink: chosenDrink, addToFavoritesButton: addToFavoritesButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredients = [[chosenDrink?.strIngredient1:chosenDrink?.strMeasure1],
                       [chosenDrink?.strIngredient2:chosenDrink?.strMeasure2],
                       [chosenDrink?.strIngredient3: chosenDrink?.strMeasure3],
                       [chosenDrink?.strIngredient4:chosenDrink?.strMeasure4],
                       [chosenDrink?.strIngredient5:chosenDrink?.strMeasure5],
                       [chosenDrink?.strIngredient6:chosenDrink?.strMeasure6],
                       [chosenDrink?.strIngredient7:chosenDrink?.strMeasure7],
                       [chosenDrink?.strIngredient8:chosenDrink?.strMeasure8],
                       [chosenDrink?.strIngredient9: chosenDrink?.strMeasure9],
                       [chosenDrink?.strIngredient10:chosenDrink?.strMeasure10],
                       [chosenDrink?.strIngredient11:chosenDrink?.strMeasure11],
                       [chosenDrink?.strIngredient12: chosenDrink?.strMeasure12],
                       [chosenDrink?.strIngredient13:chosenDrink?.strMeasure13],
                       [chosenDrink?.strIngredient14:chosenDrink?.strMeasure14],
                       [chosenDrink?.strIngredient15:chosenDrink?.strMeasure15]]

        setRightBarButton()
        setScreen()
        
        if isContentMissing {
            bottomView.heightAnchor.constraint(equalToConstant: 253).isActive = true
            scrollView.contentSize = CGSize(width: view.frame.width, height: 600)
        } else {
            bottomView.heightAnchor.constraint(equalToConstant: 400).isActive = true
            scrollView.contentSize = CGSize(width: view.frame.width, height: 780)
        }
        
        fetchImage()
        
    }
    
    func fetchImage() {
        let indicator = UIActivityIndicatorView()
        view.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: detailImageView.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: detailImageView.centerYAnchor).isActive = true
        indicator.startAnimating()
        guard let url = URL(string: chosenDrink!.strDrinkThumb) else {
            return
        }
        getImage(url: url) { [weak self] image in
            DispatchQueue.main.async {
                indicator.stopAnimating()
                self?.detailImageView.image = image
            }
        }
    }
    
    func setBackButton() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backButtonTitle = "Back"
        navigationItem.backBarButtonItem?.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 17, weight: .heavy)], for: .normal)
    }
    
    
    func setScreen() {
        DetailScreenConfig.shared.setScrollView(scrollView: scrollView, view: view)
        DetailScreenConfig.shared.setImageView(scrollView: scrollView, imageView: detailImageView, view: view)
        DetailScreenConfig.shared.setNameLabel(scrollView: scrollView, detailNameLabel: detailNameLabel, imageView: detailImageView, view: view, chosenDrink: chosenDrink)
        DetailScreenConfig.shared.setView(scrollView: scrollView, bottomView: bottomView, view: view, detailNameLabel: detailNameLabel)
        DetailScreenConfig.shared.setGlassLabel(scrollView: scrollView, detailGlassLabel: detailGlassLabel, detailNameLabel: detailNameLabel, chosenDrink: chosenDrink, view: view)
        DetailScreenConfig.shared.setIngredientsLabel(scrollView: scrollView, detailIngredientsLabel: detailIngredientsLabel, view: view, detailGlassLabel: detailGlassLabel)
        isContentMissing = DetailScreenConfig.shared.setIngredients(scrollView: scrollView, detailIngredients: detailIngredients, detailIngredientsLabel: detailIngredientsLabel, view: view, ingredients: ingredients, isContentMissing: isContentMissing)
        DetailScreenConfig.shared.setInstructionsLabel(scrollView: scrollView, detailInstructionsLabel: detailInstructionsLabel, view: view, detailIngredients: detailIngredients)
        isContentMissing = DetailScreenConfig.shared.setInstructions(scrollView: scrollView, detailInstructions: detailInstructions, detailInstructionsLabel: detailInstructionsLabel, view: view, chosenDrink: chosenDrink, isContentMissing: isContentMissing)
    }
    
    func setRightBarButton() {
        if chosenDrink?.favorited != nil {
            addToFavoritesButton = UIBarButtonItem(title: "Remove from favorites", style: .done, target: self, action: #selector(addToFavorites))
        } else {
            addToFavoritesButton = UIBarButtonItem(title: "Add to favorites", style: .done, target: self, action: #selector(addToFavorites))
        }
        navigationItem.rightBarButtonItem = addToFavoritesButton
    }

    @objc func addToFavorites() {
        for drink in FavoriteDrinks.shared.favoritedDrinks {
            if chosenDrink?.idDrink == drink.idDrink {
                if let index:Int = FavoriteDrinks.shared.favoritedDrinks.firstIndex(where: {$0.idDrink == drink.idDrink}) {
                    FavoriteDrinks.shared.favoritedDrinks.remove(at: index)
                    FavoriteDrinks.shared.saveFavourite(FavoriteDrinks.shared.favoritedDrinks)
                    addToFavoritesButton?.title = "Add to favorites"
                    return
                }
            }
        }
        chosenDrink?.favorited = true
        FavoriteDrinks.shared.favoritedDrinks.append(chosenDrink!)
        FavoriteDrinks.shared.favoritedDrinks.sort(by: { $0.strDrink < $1.strDrink })
        FavoriteDrinks.shared.saveFavourite(FavoriteDrinks.shared.favoritedDrinks)
        addToFavoritesButton?.title = "Remove from favorites"
        
        
    }

}
