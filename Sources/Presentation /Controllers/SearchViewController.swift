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
    var isSearching: Bool = false

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

extension SearchViewController: UISearchBarDelegate {

    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredMovies = movies
        } else {
            let text = searchText.lowercased()
            filteredMovies = filteredMovies.filter { movie in
                movie.originalTitle.lowercased().contains(text)
            }
        }
    }

    func searchBarSearchButtonClicked(_: UISearchBar) {}

    func searchBarTextDidEndEditing(_: UISearchBar) {
        filteredMovies = movies
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.titleView = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                            target: self,
                                                            action: #selector(handleShowSearchBar))
        searchBar.showsCancelButton = false
        searchBar.text = ""
        isSearching = false
    }
}

extension SearchViewController: UISearchResultsUpdating {

    func updateSearchResults(for _: UISearchController) {}
}
