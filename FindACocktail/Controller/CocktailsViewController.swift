//
//  ViewController.swift
//  FindACocktail
//
//  Created by Vanda S. on 26/07/2022.
//

import UIKit

class CocktailsViewController: UIViewController {

    let tableView = UITableView()
    let searchBar = UISearchBar()
    let tableActivityIndicator = UIActivityIndicatorView()
    
    let name = Notification.Name(rawValue: "co.mariam.error")
    var drinks = [Drink]()
    var keyWord: String?
    
    private lazy var session: URLSession = {
        URLCache.shared.memoryCapacity = 50 * 1024 * 1024
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: configuration)
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureSearchBar()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
      
        navigationController?.navigationBar.prefersLargeTitles = true
        NotificationCenter.default.addObserver(self, selector: #selector(presentAlert), name: name, object: nil)
    }
    
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.tableHeaderView = searchBar
        tableView.separatorStyle = .none
        
        tableView.register(CocktailCell.self, forCellReuseIdentifier: "CocktailCell")
        tableView.rowHeight = 140
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        tableView.backgroundColor = .clear
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureSearchBar() {
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search by ingredient..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        
        searchBar.delegate = self
        
        searchBar.addSubview(tableActivityIndicator)
        tableActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        tableActivityIndicator.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor).isActive = true
        tableActivityIndicator.rightAnchor.constraint(equalTo: searchBar.rightAnchor, constant: -40).isActive = true
    }
    
    @objc func presentAlert(notification: NSNotification) {
        tableActivityIndicator.stopAnimating()
        let alert = UIAlertController(title: "No matches", message: "Please try a different ingredient", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default))
        present(alert, animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}




extension CocktailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CocktailCell", for: indexPath) as! CocktailCell
        let drink = drinks[indexPath.row]
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

        let drink = drinks[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        
        getDetails(id: drink.idDrink) { [weak self] fetchedDrink in
            vc.chosenDrink = fetchedDrink.drinks[0]
            DispatchQueue.main.async {
                tableView.reloadRows(at: [indexPath], with: .none)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}



extension CocktailsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        keyWord = searchBar.text

        tableActivityIndicator.startAnimating()
        getData(keyWord: keyWord!) { [weak self] Drinks in
            self?.drinks = Drinks.drinks
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.tableActivityIndicator.stopAnimating()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
