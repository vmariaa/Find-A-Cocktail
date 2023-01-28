//
//  FavouritesViewControllersViewController.swift
//  FindACocktail
//
//  Created by Vanda S. on 21/01/2023.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    let tableView = UITableView()
    let searchBar = UISearchBar()
    let tableActivityIndicator = UIActivityIndicatorView()
    
    private lazy var session: URLSession = {
        URLCache.shared.memoryCapacity = 50 * 1024 * 1024
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: configuration)
    }()

    override func viewWillAppear(_ animated: Bool) {
        searchBar.text = ""
        FavoriteDrinks.shared.displayedDrinks = FavoriteDrinks.shared.favoritedDrinks
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.enablesReturnKeyAutomatically = false
        
        TableViewConfig.shared.configureTableView(tableView: tableView, view: view, searchBar: searchBar)
        TableViewConfig.shared.configureSearchBar(searchBar: searchBar, activityIndicator: tableActivityIndicator, placeholder: "Search for favourited drink...")
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        

    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteDrinks.shared.displayedDrinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CocktailCell", for: indexPath) as! CocktailCell
        let drink = FavoriteDrinks.shared.displayedDrinks[indexPath.row]
        let url = URL(string: drink.strDrinkThumb + "/preview")
        cell.getPreviewImage(url: url!, session: session)
        cell.cocktailLabel.text = drink.strDrink
        cell.accessoryType = .disclosureIndicator
        cell.activityIndicator.stopAnimating()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let cell: CocktailCell = (tableView.cellForRow(at: indexPath) as? CocktailCell) else {
                return
        }
        cell.activityIndicator.startAnimating()

        let drink = FavoriteDrinks.shared.displayedDrinks[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "FavoritesDetailVC") as! FavoriteDetailViewController
        vc.displayedDrink = drink
        tableView.reloadRows(at: [indexPath], with: .none)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    
}

extension FavouritesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        FavoriteDrinks.shared.displayedDrinks = []
        
        if searchText == "" {
            FavoriteDrinks.shared.displayedDrinks = FavoriteDrinks.shared.favoritedDrinks
        } else {
            for drink in FavoriteDrinks.shared.favoritedDrinks {
                if drink.strDrink.lowercased().starts(with: searchText.lowercased()) {
                    FavoriteDrinks.shared.displayedDrinks.append(drink)
                }
            }
        }
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
