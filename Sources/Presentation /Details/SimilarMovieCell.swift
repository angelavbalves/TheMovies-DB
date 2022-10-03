//
//  SimilarMovieCell.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 26/09/22.
//

import Foundation
import Kingfisher
import TinyConstraints
import UIKit

class SimilarMovieCell: UITableViewCell {

    // MARK: Properties
    static let identifer = "idSimilarMovie"

    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Constants.Color.pinkRed
        addViews()
        buildConstraintsCell()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: Views
    private var totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center

        return stackView
    }()

    private var poster: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10

        return stackView
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = .white

        return label
    }()

    private var overview: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white

        return label
    }()

    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()

    // MARK: Aux
    func setupCell(for movie: MoviesListItem) {
        titleLabel.text = movie.originalTitle
        overview.text = movie.overview
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)")
        poster.kf.indicatorType = .activity
        poster.kf.setImage(with: url)
    }

    private func addViews() {
        addSubview(totalStackView)
        totalStackView.addArrangedSubview(poster)
        totalStackView.addArrangedSubview(infoStackView)
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(separator)
        infoStackView.addArrangedSubview(overview)
    }

    private func buildConstraintsCell() {
        totalStackView.edgesToSuperview(insets: .vertical(12) + .horizontal(12))
        poster.width(frame.width * 0.3)
    }
}
