//
//  ViewController.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 31/05/22.
//

import UIKit

protocol MovieListDelegate {
    func userDidTapOnMovie(_ movie: MoviesListItem)
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
        loadMovies()
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
                    MovieDataSource.sharedInstance.saveDataOf(movies: moviesResult.results)
                    self?.loadMovies()
                }
            case .failure: return
            }
        }
    }
    
    func loadMovies() {
        MovieDataSource.sharedInstance.fetchAllDataFromCoreData { complete, movies in
            if complete {
                if !movies.isEmpty {
                    collectionViewMovie.reloadCollectionView(filteredMovies: movies)
                    collectionViewMovie.isHidden = false
                } else {
                    collectionViewMovie.isHidden = true
                }
            }
        }
    }
}

extension MovieListCollectionViewController: MovieListDelegate {
    func userDidTapOnMovie(_ movie: MoviesListItem) {
        let controller = MovieDetailsViewController(details: movie)
        navigationController?.pushViewController(controller, animated: true)
    }
}

