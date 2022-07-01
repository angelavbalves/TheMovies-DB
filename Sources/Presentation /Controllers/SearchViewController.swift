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

        navigationController?.navigationBar.barTintColor = UIColor(red: 55 / 255, green: 120 / 255, blue: 250 / 255, alpha: 1)
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

    func updateSearchResults(for _: UISearchController) {
        guard let text = searchBar.text else { return }
        print(text)
    }
}
