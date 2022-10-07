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

    func searchMovies(with searchBarText: String) {
        loadingView.show()
        Service.getMovies(endpoint: ApiEndpoints.searchMovies(page: currentPage, query: searchBarText)) { (result: Result<MoviesResponse, MovieErrorState>) in
            switch result {
                case let .success(moviesResult):
                    DispatchQueue.main.async { [weak self] in
                        let movieItems = moviesResult.results.map(MoviesListItem.init)
                        if movieItems.isEmpty {
                            self?.emptyView.show(title: "There aren't movies with this title here",
                                                 image: UIImage(named: "invalidSearch")!)
                        }
                        self?.collectionViewMovie.updateViewWithSearchResults(movieItems)
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
                        let movieItem = moviesResult.results.map(MoviesListItem.init)
                        self?.currentPage += 1
                        self?.collectionViewMovie.reloadCollectionView(movies: movieItem)
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
        if searchText.isEmpty || searchText.count < 3 {
            collectionViewMovie.resetMoviesList()
        } else {
            let text = searchText.lowercased()
            let filteredMovies = collectionViewMovie.movies.filter { movie in
                movie.originalTitle.lowercased().contains(text)
            }
            if filteredMovies.isEmpty {
                searchMovies(with: text)
            } else {
                collectionViewMovie.updateViewWithSearchResults(filteredMovies)
            }
        }
        emptyView.hide()
    }

    func searchBarCancelButtonClicked(_: UISearchBar) {
        resignFirstResponder()
        collectionViewMovie.resetMoviesList()
        emptyView.hide()
    }
}
