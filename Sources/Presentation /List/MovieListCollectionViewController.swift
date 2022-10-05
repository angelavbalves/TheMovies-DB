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

    // MARK: - Properties
    private lazy var collectionViewMovie = MovieListCollectionView(delegate: self)
    private var currentPage = 1
    private var isDarkModeSelected = false

    // MARK: - Life cycle
    override func loadView() {
        view = collectionViewMovie
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateImageButtonWhen(isSelected: true)
        navigationItem.title = "Popular Movies"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        let searchController = SearchViewController()
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }

    override func viewWillAppear(_: Bool) {
        fetchMovies()
    }

    // MARK: - Aux
    func updateImageButtonWhen(isSelected: Bool) {
        if isSelected {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "moon"),
                                                               style: .done,
                                                               target: self,
                                                               action: #selector(darkModeAction))
            isDark = true
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "sun.max"),
                                                               style: .done,
                                                               target: self,
                                                               action: #selector(darkModeAction))
            isDark = false
        }
    }

    @objc func darkModeAction() {
        configureStyle(for: appTheme)
        if isDark {
            updateImageButtonWhen(isSelected: false)
            view.window?.overrideUserInterfaceStyle = .dark
        } else {
            updateImageButtonWhen(isSelected: true)
            view.window?.overrideUserInterfaceStyle = .light
        }
    }
}

// MARK: - Delegate Collection View
extension MovieListCollectionViewController: MovieListDelegate {
    func userDidTapOnFavoriteButton(_ movie: MoviesListItem) {
        MovieDataSource.sharedInstance.saveFavoriteMovie(movie: movie)
    }

    func userDidTapOnMovie(_ movie: MoviesListItem) {
        let controller = MovieDetailsViewController(details: movie)
        navigationController?.pushViewController(controller, animated: true)
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
                case let .failure(errorState):
                    DispatchQueue.main.async { [weak self] in
                        self?.loadingView.hide()
                        self?.errorView.show(errorState,
                                             retryAction: self?.fetchMovies)
                    }
            }
        }
    }
}

// MARK: - Delegate Search Bar
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
