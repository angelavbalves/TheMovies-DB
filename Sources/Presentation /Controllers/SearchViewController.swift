//
//  SearchViewController.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 02/06/22.
//

import Foundation
import UIKit

class SearchViewController: UISearchController {

    // MARK: Properties
    var movies: [MoviesListItem] = []
    var filteredMovies: [MoviesListItem] = []

    // MARK: Life cycle
    override func viewDidLoad() {
        configureNavController()
        navigationItem.searchController = self
    }

    // MARK: Aux
    func configureNavController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    @objc func handleShowSearchBar() {
        searchBar.showsCancelButton = true
        searchBar.becomeFirstResponder()
        searchBar.placeholder = "Search"
    }
}

extension SearchViewController: UISearchResultsUpdating {

    func updateSearchResults(for _: UISearchController) {}
}
