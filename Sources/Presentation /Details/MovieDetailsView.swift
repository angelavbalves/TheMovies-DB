//
//  MovieDetailsView.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 06/06/22.
//

import CoreAudio
import Foundation
import Kingfisher
import TinyConstraints
import UIKit

class MovieDetailsView: TMView, UIScrollViewDelegate {

    // MARK: Properties
    private let movieDetails: MoviesListItem
    private var similarMovies: [MoviesListItem] = [] {
        didSet { tableViewHeight.constant = tableViewContentSize }
    }
    private let didTapOnSimilarMovie: (_ movie: MoviesListItem) -> Void
    private let fetchMoreSimilarMovies: () -> Void
    private var isLoadingMoreSimilarMovies = false

    // MARK: Constants
    private let rowHeight = 200.0
    private lazy var tableViewHeight: NSLayoutConstraint = similarMoviesTableView.height(tableViewContentSize)
    private var tableViewContentSize: Double {
        let moviesCount = similarMovies.count
        return Double(moviesCount) * rowHeight
    }

    // MARK: Init
    init(details: MoviesListItem,
         didTapOnSimilarMovie: @escaping (_ movie: MoviesListItem) -> Void,
         fetchMoreSimilarMovies: @escaping () -> Void)
    {
        self.didTapOnSimilarMovie = didTapOnSimilarMovie
        self.fetchMoreSimilarMovies = fetchMoreSimilarMovies
        movieDetails = details
        super.init()
        setupView()
    }

    // MARK: - Aux
    func setupTableView(with similarMovies: [MoviesListItem]) {
        self.similarMovies += similarMovies
        similarMoviesTableView.reloadData()
        isLoadingMoreSimilarMovies = false
    }

    private func setupView() {
        title.text = movieDetails.originalTitle
        realeaseDate.text = movieDetails.release_date
        overview.text = movieDetails.overview
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movieDetails.poster_path)")
        posterImageView.kf.indicatorType = .activity
        posterImageView.kf.setImage(with: url,
                           placeholder: UIImage(named: "movieNotFound")!
        )
    }

    // MARK: - Views
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        return scrollView
    }()

    private lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()

    private var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.numberOfLines = 0
        label.textColor = .white

        return label
    }()

    private let posterImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8.0
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()

    private let realeaseDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white

        return label
    }()

    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()

    private let overview: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.justified
        return label
    }()

    lazy var similarMoviesTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .red
        tv.isScrollEnabled = false
        tv.register(SimilarMovieCell.self, forCellReuseIdentifier: SimilarMovieCell.identifer)
        tv.delegate = self
        tv.dataSource = self
        tv.rowHeight = rowHeight
        tv.backgroundColor = Theme.currentTheme.colors.backgroudColor.rawValue
        return tv
    }()

    override func configureSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(detailsStackView)
        scrollView.addSubview(similarMoviesTableView)

        detailsStackView.addArrangedSubview(posterImageView)
        detailsStackView.addArrangedSubview(title)
        detailsStackView.addArrangedSubview(realeaseDate)
        detailsStackView.addArrangedSubview(separator)
        detailsStackView.addArrangedSubview(overview)
    }

    override func configureConstraints() {
        // Scroll view
        scrollView.edgesToSuperview(usingSafeArea: true)

        // Details
        detailsStackView.top(to: scrollView, offset: 16)
        detailsStackView.leading(to: safeAreaLayoutGuide, offset: 16)
        detailsStackView.trailing(to: safeAreaLayoutGuide, offset: -16)

        posterImageView.widthToSuperview()
        posterImageView.height(255)

        // Similar movies
        similarMoviesTableView.widthToSuperview()
        similarMoviesTableView.topToBottom(of: detailsStackView)
        similarMoviesTableView.bottom(to: scrollView)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        let distanceFromBottom = contentHeight - offsetY

        if
            isLoadingMoreSimilarMovies == false,
            contentHeight > height,
            distanceFromBottom < height
        {
            isLoadingMoreSimilarMovies = true
            fetchMoreSimilarMovies()
        }
    }
}

// MARK: - Data source
extension MovieDetailsView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return similarMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SimilarMovieCell.identifer, for: indexPath) as! SimilarMovieCell
        let similarMovie = similarMovies[indexPath.row]
        cell.setupCell(for: similarMovie)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Similar movies"
        label.textColor = Theme.currentTheme.colors.textColor.rawValue
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22.0)
        return label
    }
}

// MARK: - Delegate
extension MovieDetailsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let similarMovieSelected = similarMovies[indexPath.row]
        didTapOnSimilarMovie(similarMovieSelected)
    }
}
