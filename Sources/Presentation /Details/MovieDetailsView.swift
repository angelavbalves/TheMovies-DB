//
//  MovieDetailsView.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 06/06/22.
//

import Foundation
import UIKit

class MovieDetailsView: UIView {

    // MARK: Properties
    private let movieDetails: MoviesListItem

    // MARK: Init
    init(details: MoviesListItem) {
        movieDetails = details
        super.init(frame: .zero)
        backgroundColor = Constants.Color.pinkRed
        addViews()
        setupView()
        buildConstraintsView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Views
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private lazy var imageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()

    private var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22)
        label.numberOfLines = 0
        label.textColor = .white
        label.text = "Title Movie"

        return label
    }()

    private let posterPath: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let realeaseDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white

        return label
    }()

    private let separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()

    private let overview: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.justified
        return label
    }()

    // MARK: Aux
    func setupView() {
        title.text = movieDetails.originalTitle
        posterPath.downloadImage(from: URL(string: "https://image.tmdb.org/t/p/w500\(movieDetails.poster_path)")!)
        realeaseDate.text = movieDetails.release_date
        overview.text = movieDetails.overview
    }

    private func addViews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(detailsStackView)
        detailsStackView.addArrangedSubview(title)
        imageStackView.addArrangedSubview(posterPath)
        detailsStackView.addArrangedSubview(imageStackView)
        detailsStackView.addArrangedSubview(realeaseDate)
        detailsStackView.addArrangedSubview(separator)
        detailsStackView.addArrangedSubview(overview)
    }

    private func buildConstraintsView() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.widthAnchor.constraint(equalTo: widthAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            detailsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            detailsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            detailsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            detailsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

            posterPath.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            posterPath.heightAnchor.constraint(equalTo: posterPath.widthAnchor, multiplier: 1.2)

        ])
    }
}
