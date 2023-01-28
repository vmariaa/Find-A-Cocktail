//
//  TableViewConfiguration.swift
//  FindACocktail
//
//  Created by Vanda S. on 21/01/2023.
//

import Foundation
import UIKit

class TableViewConfig {
    
    private init() {}
    static let shared = TableViewConfig()
    
    
    func configureTableView(tableView: UITableView, view: UIView, searchBar: UISearchBar) {
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
    }
    
    func configureSearchBar(searchBar: UISearchBar, activityIndicator: UIActivityIndicatorView, placeholder: String) {
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = placeholder
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        
        searchBar.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor).isActive = true
        activityIndicator.rightAnchor.constraint(equalTo: searchBar.rightAnchor, constant: -40).isActive = true
    }
    
}

