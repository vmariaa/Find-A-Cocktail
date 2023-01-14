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

        
        setScrollView()
        setBackButton()
        
        setImageView()
        setNameLabel()
        setView()
        setGlassLabel()
       
        setIngredientsLabel()
        setIngredients()
        setInstructionsLabel()
        setInstructions()
        
        if isContentMissing {
            bottomView.heightAnchor.constraint(equalToConstant: 300).isActive = true
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
    
    func setScrollView() {
        let screen: CGRect = UIScreen.main.bounds
        let screenWidth = screen.width
        let screenHeight = screen.height
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))

        scrollView.layoutIfNeeded()
        scrollView.isScrollEnabled = true
        
        view.addSubview(scrollView)
    }

    func setImageView() {
        scrollView.addSubview(detailImageView)
        detailImageView.translatesAutoresizingMaskIntoConstraints = false
        detailImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -45).isActive = true
        detailImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        detailImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        detailImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        
        detailImageView.layer.cornerRadius = 13
        detailImageView.contentMode = .scaleAspectFill
        detailImageView.clipsToBounds = true
    }
    
    func setNameLabel() {
        scrollView.addSubview(detailNameLabel)
        detailNameLabel.translatesAutoresizingMaskIntoConstraints = false
        detailNameLabel.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: 15).isActive = true
        detailNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        detailNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        detailNameLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        detailNameLabel.text = chosenDrink?.strDrink
        detailNameLabel.numberOfLines = 0
    }
    
    func setGlassLabel() {
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
    
    func setInstructionsLabel() {
        scrollView.addSubview(detailInstructionsLabel)
        detailInstructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        detailInstructionsLabel.topAnchor.constraint(equalTo: detailIngredients.bottomAnchor, constant: 20).isActive = true
        detailInstructionsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        detailInstructionsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        detailInstructionsLabel.text = "Instructions"
        detailInstructionsLabel.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        
    }
    
    func setInstructions() {
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
       
        
        
    }
    
    func setIngredientsLabel() {
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
    
    func setIngredients() {
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
        
    }
    
    func setView() {
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


}
