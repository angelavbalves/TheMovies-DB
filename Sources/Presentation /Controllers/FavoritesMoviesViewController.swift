//
//  FavoritesMoviesViewController.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 10/06/22.
//

import Foundation
import UIKit

class FavoritesMoviesViewController: UIViewController {
    
    lazy var favoriteMovieView = MoviesFavoritesView(delegate: self)
    
    override func loadView() {
        view = favoriteMovieView
    }

}
extension FavoritesMoviesViewController: MovieListDelegate {
    func userDidTapOnMovie(_ movie: MoviesListItem) {
        let controller = MovieDetailsViewController(details: movie)
        navigationController?.pushViewController(controller, animated: true)
    }
}
