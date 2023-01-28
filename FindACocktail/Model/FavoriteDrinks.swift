//
//  FavoriteDrinks.swift
//  FindACocktail
//
//  Created by Vanda S. on 21/01/2023.
//

import Foundation

class FavoriteDrinks {
    
    private init() {}
    static let shared = FavoriteDrinks()
    
    var favoritedDrinks = [Drink]()
    var displayedDrinks = [Drink]()
    var filteredDrinks = [Drink]()
    
    private static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private let archiveUrl = documentsDirectory.appendingPathComponent("favourite").appendingPathExtension("plist")
    
    func loadFavourite() -> [Drink]? {
        guard let favourite = try? Data(contentsOf: archiveUrl) else {
            return nil
        }
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<Drink>.self, from: favourite)
    }
    
    func saveFavourite(_ favourites: [Drink]) {
        let propertyListEncoder = PropertyListEncoder()
        guard let codedfavourite = try? propertyListEncoder.encode(favourites) else {
            return
        }
        do {
            try codedfavourite.write(to: archiveUrl, options: .noFileProtection)
        } catch {
            print("Couldn't save data, archiveURL: \(archiveUrl)")
        }
    }
    
}
