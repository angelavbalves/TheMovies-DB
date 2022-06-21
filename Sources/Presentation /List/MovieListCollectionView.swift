//
//  MovieListCollectionView.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 31/05/22.
//

import Foundation
import UIKit

class MovieListCollectionView: UIView {

    // MARK: Properties
    private var movies: [MoviesListItem] = []
    private var filteredMovies: [MoviesListItem] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    private var delegate: MovieListDelegate?

    // MARK: Views
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()

    // MARK: Init
    init(delegate: MovieListDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        collectionView.register(MovieListCell.self, forCellWithReuseIdentifier: MovieListCell.identifer)
        setupView()
        collectionView.backgroundColor = Constants.Color.pinkRed
        collectionView.allowsMultipleSelection = true
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Aux
    private func setupView() {
        addSubview(collectionView)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: heightAnchor),
        ])
    }

    func reloadCollectionView(filteredMovies: [MoviesListItem]) {
        self.filteredMovies = filteredMovies
        collectionView.reloadData()
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
