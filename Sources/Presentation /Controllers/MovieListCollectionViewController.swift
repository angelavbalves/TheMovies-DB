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
    
    lazy var collectionViewMovie = MovieListCollectionView(delegate: self)
    var filteredMovies: [MoviesListItem] = []
    var movies: [MoviesListItem] = []
    
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
//                    MovieDataSource.sharedInstance.saveDataOf(movies: moviesResult.results)
//                    self?.loadMovies()
                }
            case .failure: return
            }
        }
    }
    
//    func loadMovies() {
//        MovieDataSource.sharedInstance.fetchAllDataFromCoreData { [weak self] complete, movies in
//            if complete {
//                if !movies.isEmpty {
//                    self?.collectionViewMovie.reloadCollectionView(filteredMovies: movies)
//                    self?.collectionViewMovie.isHidden = false
//                } else {
//                    self?.fetchMovies()
//                }
//            }
//        }
//    }
}

extension MovieListCollectionViewController: MovieListDelegate {
    func userDidTapOnFavoriteButton(_ movie: MoviesListItem) {
        MovieDataSource.sharedInstance.saveDataOf(movie: movie)
        
    }
    
    func userDidTapOnMovie(_ movie: MoviesListItem) {
        let controller = MovieDetailsViewController(details: movie)
        navigationController?.pushViewController(controller, animated: true)
    }
}

