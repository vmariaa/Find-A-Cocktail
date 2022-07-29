//
//  CocktailService.swift
//  FindACocktail
//
//  Created by Vanda S. on 26/07/2022.
//

import Foundation
import UIKit


func getData(keyWord: String, completion: @escaping (Drinks)->()) {
    let replaced = keyWord.replacingOccurrences(of: " ", with: "%20")
    guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=" + replaced) else {
        return
    }
    let urlRequest = URLRequest(url: url)
    URLSession.shared.dataTask(with: urlRequest) { data, response, error in
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let data = data else { return }
        print(data)
        guard let drinks = try? JSONDecoder().decode(Drinks.self, from: data) else {
            DispatchQueue.main.async {
                let name = Notification.Name(rawValue: "co.mariam.error")
                NotificationCenter.default.post(name: name, object: nil)
            }
            return
        }
        print(drinks)
        completion(drinks)
    }.resume()
}


func getDetails(id: String, completion: @escaping (Drinks)->()) {
    
    guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=" + id) else {
        return
    }
    let urlRequest = URLRequest(url: url)
    URLSession.shared.dataTask(with: urlRequest) { data, response, error in
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let data = data else { return }
        guard let drink = try? JSONDecoder().decode(Drinks.self, from: data) else {
            return
        }
        completion(drink)
    }.resume()
}



func getImage(url: URL, completion: @escaping (UIImage)->()) {
 
    let urlRequest = URLRequest(url: url)

    URLSession.shared.dataTask(with: urlRequest) { data, response, error in
        if let error =  error {
            print (error.localizedDescription)
            return
        }
        guard let data = data  else { return }
        guard let image = UIImage(data: data) else { return }
        completion(image)
    }.resume()
}
