//
//  FavoritesMoviesViewController.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 10/06/22.
//

import Foundation
import UIKit

protocol FavoritesMoviesDelegate {
    func userDidTapOnFavoriteMovie(_ movie: MoviesListItem)
}

class FavoritesMoviesViewController: UIViewController {

    // MARK: Properties
    private lazy var favoriteMovieView = FavoritesMoviesView(delegate: self)
    private var movie: MoviesListItem?


    // MARK: Life cycle
    override func loadView() {
        view = favoriteMovieView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMovies()
    }

    // MARK: Aux
    func loadMovies() {
        MovieDataSource.sharedInstance.fetchAllDataFromCoreData { [weak self] complete, movies in
            if complete {
                self?.favoriteMovieView.reloadTableView(favoritesMovies: movies)
            }
        }
    }
}

extension FavoritesMoviesViewController: FavoritesMoviesDelegate {
    func userDidTapOnFavoriteMovie(_ movie: MoviesListItem) {
        let controller = MovieDetailsViewController(details: movie)
        navigationController?.pushViewController(controller, animated: true)
    }
}
