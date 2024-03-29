//
//  MovieListCollectionView.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 31/05/22.
//

import Foundation
import TinyConstraints
import UIKit

class MovieListCollectionView: TMView {

    // MARK: Properties
    private(set) var movies: [MoviesListItem] = []
    private var isLoadingMoreMovies = false
    private var isFiltering = false
    private(set) var filteredMovies: [MoviesListItem] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    private var delegate: MovieListDelegate?

    // MARK: - Views
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()

    // MARK: - Init
    init(delegate: MovieListDelegate) {
        self.delegate = delegate
        super.init()
        collectionView.register(MovieListCell.self, forCellWithReuseIdentifier: MovieListCell.identifer)
        collectionView.backgroundColor = Theme.currentTheme.colors.backgroudColor.rawValue
        collectionView.allowsMultipleSelection = true
    }

    // MARK: - Aux
    override func configureSubviews() {
        addSubview(collectionView)
    }

    override func configureConstraints() {
        collectionView.edgesToSuperview()
    }

    func updateViewWithSearchResults(_ results: [MoviesListItem]) {
        filteredMovies = results
        isFiltering = true
        collectionView.reloadData()
    }

    func resetMoviesList() {
        filteredMovies = movies
        isFiltering = false
        collectionView.reloadData()
    }

    func reloadCollectionView(movies: [MoviesListItem]) {
        self.movies = movies
        filteredMovies += movies
        isLoadingMoreMovies = false
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        let distanceFromBottom = contentHeight - offsetY

        if
            !isFiltering,
            !isLoadingMoreMovies,
            contentHeight > height,
            distanceFromBottom < height
        {
            isLoadingMoreMovies = true
            delegate?.fetchMovies()
        }
    }
}

extension MovieListCollectionView: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        filteredMovies.count
    }

    func numberOfSections(in _: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCell.identifer, for: indexPath) as! MovieListCell

        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.cornerRadius = 8.0

        let movie = filteredMovies[indexPath.row]

        cell.setup(for: movie)

        return cell
    }
}

extension MovieListCollectionView: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = filteredMovies[indexPath.row]
        delegate?.userDidTapOnMovie(movie)
    }
}

extension MovieListCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width * 0.45
        return CGSize(width: width, height: width * 1.5)
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 25, left: 15, bottom: 15, right: 15)
    }
}
