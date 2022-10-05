//
//  MoviesFavoritesView.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 10/06/22.
//

import Foundation
import TinyConstraints
import UIKit

class FavoritesMoviesView: TMView {

    // MARK: Properties
    private var movies: [MoviesListItem] = []
    private var delegate: FavoritesMoviesDelegate?

    // MARK: Views
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: UITableView.Style.plain)
        tv.delegate = self
        tv.dataSource = self
        tv.rowHeight = 200
        tv.register(FavoriteMovieCell.self, forCellReuseIdentifier: FavoriteMovieCell.identifer)
        tv.backgroundColor = Theme.currentTheme.colors.backgroudColor.rawValue
        return tv
    }()

    // MARK: Init
    init(delegate: FavoritesMoviesDelegate) {
        self.delegate = delegate
        super.init()
    }

    override func configureSubviews() {
        addSubview(tableView)
    }

    override func configureConstraints() {
        tableView.edgesToSuperview()
    }

    func reloadTableView(favoritesMovies: [MoviesListItem]) {
        movies = favoritesMovies
        tableView.reloadData()
    }
}

// MARK: - Data Source
extension FavoritesMoviesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCellFavorite", for: indexPath) as! FavoriteMovieCell
        let movie = movies[indexPath.row]
        cell.setupView(for: movie)
        cell.selectionStyle = .none
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            MovieDataSource.sharedInstance.removeFavoriteMovie(id: movies[indexPath.row].id)
            movies.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

// MARK: - Delegate
extension FavoritesMoviesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        delegate?.userDidTapOnFavoriteMovie(movie)
    }
}
