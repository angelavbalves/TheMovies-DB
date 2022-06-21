//
//  ViewController.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 31/05/22.
//

import UIKit

protocol MovieListDelegate {
    func userDidTapOnMovie(_ movie: MoviesListItem)
    func userDidTapOnFavoriteButton(_ movie: MoviesListItem)
}

class MovieListCollectionViewController: UIViewController {

    // MARK: Properties
    private lazy var collectionViewMovie = MovieListCollectionView(delegate: self)

    // MARK: Life cycle
    override func loadView() {
        view = collectionViewMovie
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavController()
        navigationItem.title = "Popular Movies"
        navigationItem.searchController = SearchViewController()
    }

    override func viewWillAppear(_ animated: Bool) {
        fetchMovies()
    }

    // MARK: Aux
    func setupNavController() {
        navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.barTintColor = Constants.Color.pink
        navigationController?.navigationBar.tintColor = .black
    }

    func fetchMovies() {
        Service.getAllMovies { result in
            switch result {
            case let .success(moviesResult):
                DispatchQueue.main.async { [weak self] in
                    self?.collectionViewMovie.reloadCollectionView(filteredMovies: moviesResult.results.map(MoviesListItem.init))
                }
            case .failure: return
            }
        }
    }
}

extension MovieListCollectionViewController: MovieListDelegate {
    func userDidTapOnFavoriteButton(_ movie: MoviesListItem) {
        MovieDataSource.sharedInstance.saveFavoriteMovie(movie: movie)
    }

    func userDidTapOnMovie(_ movie: MoviesListItem) {
        let controller = MovieDetailsViewController(details: movie)
        navigationController?.pushViewController(controller, animated: true)
    }
}
