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
    func fetchMovies()
}

class MovieListCollectionViewController: TMViewController {

    // MARK: Properties
    private lazy var collectionViewMovie = MovieListCollectionView(delegate: self)
    private var currentPage = 1

    // MARK: Life cycle
    override func loadView() {
        view = collectionViewMovie
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavController()
        navigationItem.title = "Popular Movies"
        let searchController = SearchViewController()
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }

    override func viewWillAppear(_: Bool) {
        fetchMovies()
    }

    // MARK: Aux
    func setupNavController() {
        navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.barTintColor = Constants.Color.pink
        navigationController?.navigationBar.tintColor = .black
    }

    func fetchMovies() {
        loadingView.show()
        Service.getMovies(endpoint: ApiEndpoints.movies(page: currentPage)) { (result: Result<MoviesResponse, MovieErrorState>) in
            switch result {
                case let .success(moviesResult):
                    DispatchQueue.main.async { [weak self] in
                        self?.collectionViewMovie.reloadCollectionView(filteredMovies: moviesResult.results.map(MoviesListItem.init))
                        self?.currentPage += 1
                        self?.loadingView.hide()
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

extension MovieListCollectionViewController: UISearchBarDelegate {

    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            collectionViewMovie.resetMoviesList()
        } else {
            let text = searchText.lowercased()
            let filteredMovies = collectionViewMovie.filteredMovies.filter { movie in
                movie.originalTitle.lowercased().contains(text)
            }
            collectionViewMovie.updateViewWithSearchResults(filteredMovies)
        }

        func searchBarSearchButtonClicked(_: UISearchBar) {}

        func searchBarCancelButtonClicked(_: UISearchBar) {
            collectionViewMovie.resetMoviesList()
        }
    }
}
