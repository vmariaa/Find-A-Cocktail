//
//  DetailScreenConfiguration.swift
//  FindACocktail
//
//  Created by Vanda S. on 24/01/2023.
//

import Foundation
import UIKit

class DetailScreenConfig {
    
    private init() {}
    static let shared = DetailScreenConfig()
    
    
    
    func setScrollView(scrollView: UIScrollView, view: UIView) {
        let screen: CGRect = UIScreen.main.bounds
        let screenWidth = screen.width
        let screenHeight = screen.height
        scrollView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)

        scrollView.layoutIfNeeded()
        scrollView.isScrollEnabled = true
        
        view.addSubview(scrollView)
    }
    
    func setImageView(scrollView: UIScrollView, imageView: UIImageView, view: UIView) {
        scrollView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -45).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        
        imageView.layer.cornerRadius = 13
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
    func setNameLabel(scrollView: UIScrollView, detailNameLabel: UILabel, imageView: UIImageView, view: UIView, chosenDrink: Drink?) {
        scrollView.addSubview(detailNameLabel)
        detailNameLabel.translatesAutoresizingMaskIntoConstraints = false
        detailNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15).isActive = true
        detailNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        detailNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        detailNameLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        detailNameLabel.text = chosenDrink?.strDrink
        detailNameLabel.numberOfLines = 0
    }
    
    func setGlassLabel(scrollView: UIScrollView, detailGlassLabel: UILabel, detailNameLabel: UILabel, chosenDrink: Drink?, view: UIView) {
        scrollView.addSubview(detailGlassLabel)
        detailGlassLabel.translatesAutoresizingMaskIntoConstraints = false
        detailGlassLabel.topAnchor.constraint(equalTo: detailNameLabel.bottomAnchor, constant: 25).isActive = true
        detailGlassLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        detailGlassLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        
        if let glass = chosenDrink?.strGlass {
            detailGlassLabel.text = "Glass type: \(glass)"
        } else {
            detailGlassLabel.text = "Glass tyoe: Not specified"
        }
        detailGlassLabel.text = "Glass type: \((chosenDrink?.strGlass)!)"
        detailGlassLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    
    func setInstructionsLabel(scrollView: UIScrollView, detailInstructionsLabel: UILabel, view: UIView, detailIngredients: UITextView) {
        scrollView.addSubview(detailInstructionsLabel)
        detailInstructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        detailInstructionsLabel.topAnchor.constraint(equalTo: detailIngredients.bottomAnchor, constant: 20).isActive = true
        detailInstructionsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        detailInstructionsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        detailInstructionsLabel.text = "Instructions"
        detailInstructionsLabel.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
    }
    
    func setInstructions(scrollView: UIScrollView, detailInstructions: UITextView, detailInstructionsLabel: UILabel, view: UIView, chosenDrink: Drink?, isContentMissing: Bool) -> Bool{
        var isContentMissing = isContentMissing
        scrollView.addSubview(detailInstructions)
        detailInstructions.translatesAutoresizingMaskIntoConstraints = false
        detailInstructions.topAnchor.constraint(equalTo: detailInstructionsLabel.bottomAnchor).isActive = true
        detailInstructions.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        detailInstructions.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        detailInstructions.heightAnchor.constraint(equalToConstant: 135).isActive = true
        
        if let instructions = chosenDrink?.strInstructions {
            detailInstructions.text = instructions.firstUppercased
        } else {
            detailInstructions.text = "Not specified"
            isContentMissing = true
            detailInstructions.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        detailInstructions.font = UIFont.systemFont(ofSize: 18)
        detailInstructions.textColor = .darkGray.withAlphaComponent(0.9)
        detailInstructions.textAlignment = .justified
        detailInstructions.isEditable = false
        detailInstructions.backgroundColor = .clear
        return isContentMissing
    }
    
    func setIngredientsLabel(scrollView: UIScrollView, detailIngredientsLabel: UILabel, view: UIView, detailGlassLabel: UILabel) {
        scrollView.addSubview(detailIngredientsLabel)
        
        detailIngredientsLabel.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        detailIngredientsLabel.layer.cornerRadius = 5
        detailIngredientsLabel.text = "Ingredients"
      
    
        detailIngredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        detailIngredientsLabel.topAnchor.constraint(equalTo: detailGlassLabel.bottomAnchor, constant: 21).isActive = true
        detailIngredientsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        detailIngredientsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        detailIngredientsLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setIngredients(scrollView: UIScrollView, detailIngredients: UITextView, detailIngredientsLabel: UILabel, view: UIView, ingredients: [Dictionary<String?, String?>], isContentMissing: Bool) -> Bool {
        var isContentMissing = isContentMissing
        scrollView.addSubview(detailIngredients)
        detailIngredients.translatesAutoresizingMaskIntoConstraints = false
        detailIngredients.topAnchor.constraint(equalTo: detailIngredientsLabel.bottomAnchor).isActive = true
        detailIngredients.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        detailIngredients.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        detailIngredients.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        var string = ""
        for i in ingredients {
            for (key, value) in i {
                if let key = key, let value = value {
                string.append("\(key) - \(value)\n")
                }
            }
        }
        
        if string != "" {
            detailIngredients.text = string
            string.removeLast()
        } else {
            detailIngredients.text = "Not specified"
            isContentMissing = true
            detailIngredients.heightAnchor.constraint(equalToConstant: 30).isActive = true
        }
        
        detailIngredients.font = UIFont.systemFont(ofSize: 17)
        detailIngredients.textColor = .darkGray.withAlphaComponent(0.9)
        detailIngredients.isEditable = false
        detailIngredients.isScrollEnabled = true
        detailIngredients.backgroundColor = .clear
        return isContentMissing
    }

    func setView(scrollView: UIScrollView, bottomView: UIView, view: UIView, detailNameLabel: UILabel) {
        scrollView.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.topAnchor.constraint(equalTo: detailNameLabel.bottomAnchor, constant: 13).isActive = true
        bottomView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        bottomView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true

        bottomView.layer.cornerRadius = 13
        bottomView.backgroundColor = .white.withAlphaComponent(0.99)
        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.shadowOffset = CGSize(width: 5, height: 5)
        bottomView.layer.shadowRadius = 9
        bottomView.layer.shadowOpacity = 0.3
    }
    
    func missingContentCheck(isContentMissing: Bool, bottomView: UIView, scrollView: UIScrollView, view: UIView) {
        if isContentMissing {
            bottomView.heightAnchor.constraint(equalToConstant: 253).isActive = true
            scrollView.contentSize = CGSize(width: view.frame.width, height: 600)
        } else {
            bottomView.heightAnchor.constraint(equalToConstant: 400).isActive = true
            scrollView.contentSize = CGSize(width: view.frame.width, height: 800)
        }
    }
    
    func checkForFavorite(displayedDrink: Drink?, addToFavoritesButton: UIBarButtonItem?) -> Drink? {
        var displayedDrink = displayedDrink
        for drink in FavoriteDrinks.shared.favoritedDrinks {
            if displayedDrink?.idDrink == drink.idDrink {
                displayedDrink?.favorited = drink.favorited
                addToFavoritesButton?.title = "Remove from favorites"
                return displayedDrink
            } else {
                addToFavoritesButton?.title = "Add to favorites"
            }
        }
        return displayedDrink
    }


    
}
