//
//  MovieListCell.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 31/05/22.
//

import Foundation
import Kingfisher
import TinyConstraints
import UIKit

class MovieListCell: UICollectionViewCell {

    // MARK: - Properties
    static let identifer = "idCellHome"
    private var movie: MoviesListItem?
    private var movieIsFavorite = false {
        didSet {
            updateButtonState(isSelected: movieIsFavorite)
        }
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviewsCell()
        buildCellConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError()
    }

    // MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()

        backgroundColor = Constants.Color.rose
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        updateButtonState(isSelected: movieIsFavorite)
    }

    // MARK: - Views
    var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    var stackViewCell: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()

    var titleMovie: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()

    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setContentHuggingPriority(.required, for: .horizontal)
        let buttonSymbol = UIImage(systemName: "star")
        button.setImage(buttonSymbol, for: .normal)
        button.addTarget(self, action: #selector(buttonSelected(_:)), for: .touchUpInside)
        return button
    }()

    // MARK: - Action
    @objc func buttonSelected(_: UIButton) {
        if movieIsFavorite {
            if let movie = movie {
                MovieDataSource.sharedInstance.removeFavoriteMovie(id: movie.id)
                movieIsFavorite = false
                updateButtonState(isSelected: false)
            }
        } else {
            if let movie = movie {
                MovieDataSource.sharedInstance.saveFavoriteMovie(movie: movie)
                movieIsFavorite = true
                updateButtonState(isSelected: true)
            }
        }
    }

    // MARK: - Aux
    func updateButtonState(isSelected: Bool) {
        if isSelected {
            let buttonSymbolFill = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal)
            favoriteButton.setImage(buttonSymbolFill, for: .normal)
        } else {
            let buttonSymbol = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
            favoriteButton.setImage(buttonSymbol, for: .normal)
        }
    }

    func setup(for movie: MoviesListItem) {
        titleMovie.text = movie.originalTitle
        self.movie = movie
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)")
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url)
        movieIsFavorite = MovieDataSource.sharedInstance.checkMovieInCoreDataFor(id: movie.id)
    }

    func addSubviewsCell() {
        addSubview(stackViewCell)
        stackViewCell.addArrangedSubview(imageView)
        stackViewCell.addArrangedSubview(titleStackView)

        titleStackView.addArrangedSubview(titleMovie)
        titleStackView.addArrangedSubview(favoriteButton)
    }

    func buildCellConstraints() {
        stackViewCell.edgesToSuperview(insets: .top(8) + .left(6) + .right(6) + .bottom(2), usingSafeArea: true)
        imageView.height(frame.height * 0.75)
    }
}
