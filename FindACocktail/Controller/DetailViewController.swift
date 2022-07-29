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
    
    let detailImageView = UIImageView()
    let detailNameLabel = UILabel()
    let detailGlassLabel = UILabel()
    let detailInstructionsLabel = UILabel()
    let detailInstructions = UITextView()
    let detailIngredientsLabel = UILabel()
    let detailIngredients = UITextView()

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

        setNameLabel()
        setImageView()
        setGlassLabel()
        setInstructionsLabel()
        setIngredientsLabel()
        setIngredients()
        setInstructions()
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
    
    
    func setImageView() {
        view.addSubview(detailImageView)
        detailImageView.translatesAutoresizingMaskIntoConstraints = false
        detailImageView.topAnchor.constraint(equalTo: detailNameLabel.bottomAnchor, constant: 30).isActive = true
        detailImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        detailImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        detailImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        
        detailImageView.contentMode = .scaleAspectFill
        detailImageView.clipsToBounds = true
    }
    
    func setNameLabel() {
        view.addSubview(detailNameLabel)
        detailNameLabel.translatesAutoresizingMaskIntoConstraints = false
        detailNameLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: -45).isActive = true
        detailNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        detailNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        detailNameLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        detailNameLabel.text = chosenDrink?.strDrink
        detailNameLabel.numberOfLines = 0
    }
    
    func setGlassLabel() {
        view.addSubview(detailGlassLabel)
        detailGlassLabel.translatesAutoresizingMaskIntoConstraints = false
        detailGlassLabel.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: 20).isActive = true
        detailGlassLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        detailGlassLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        if let glass = chosenDrink?.strGlass {
            detailGlassLabel.text = "Glass type: \(glass)"
        } else {
            detailGlassLabel.text = "Glass tyoe: Not specified"
        }
        
        detailGlassLabel.text = "Glass type: \((chosenDrink?.strGlass)!)"
        detailGlassLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    
    func setInstructionsLabel() {
        view.addSubview(detailInstructionsLabel)
        detailInstructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        detailInstructionsLabel.topAnchor.constraint(equalTo: detailGlassLabel.bottomAnchor, constant: 20).isActive = true
        detailInstructionsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        detailInstructionsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        detailInstructionsLabel.text = "Instructions"
        detailInstructionsLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    
    func setInstructions() {
        view.addSubview(detailInstructions)
        detailInstructions.translatesAutoresizingMaskIntoConstraints = false
        detailInstructions.topAnchor.constraint(equalTo: detailInstructionsLabel.bottomAnchor).isActive = true
        detailInstructions.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        detailInstructions.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -18).isActive = true
        detailInstructions.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        
        if let instructions = chosenDrink?.strInstructions {
            detailInstructions.text = instructions.firstUppercased
        } else {
            detailInstructions.text = "Not specified"
        }
        
        detailInstructions.font = UIFont.systemFont(ofSize: 18)
        detailInstructions.textAlignment = .justified
        detailInstructions.isEditable = false
        
    }
    
    func setIngredientsLabel() {
        view.addSubview(detailIngredientsLabel)
        
        detailIngredientsLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        detailIngredientsLabel.text = "Ingredients"
        
        detailIngredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        detailIngredientsLabel.topAnchor.constraint(equalTo: detailNameLabel.bottomAnchor, constant: 25).isActive = true
        detailIngredientsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20).isActive = true
        detailIngredientsLabel.leftAnchor.constraint(equalTo: detailImageView.rightAnchor, constant: 12).isActive = true
    }
    
    func setIngredients() {
        view.addSubview(detailIngredients)
        detailIngredients.translatesAutoresizingMaskIntoConstraints = false
        detailIngredients.topAnchor.constraint(equalTo: detailIngredientsLabel.bottomAnchor).isActive = true
        detailIngredients.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        detailIngredients.leftAnchor.constraint(equalTo: detailImageView.rightAnchor, constant: 8).isActive = true
        detailIngredients.bottomAnchor.constraint(equalTo: detailImageView.bottomAnchor).isActive = true
        
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
        }
        
        detailIngredients.font = UIFont.systemFont(ofSize: 17)
        detailIngredients.isEditable = false
        detailIngredients.isScrollEnabled = true
        
    }
    
    


}
