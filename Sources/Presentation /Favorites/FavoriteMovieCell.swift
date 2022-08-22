//
//  MovieFavoriteCell.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 10/06/22.
//

import Foundation
import UIKit

class FavoriteMovieCell: UITableViewCell {

    // MARK: Properties
    static let identifer = "idCellFavorite"

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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center

        return stackView
    }()

    private var poster: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true

        return imageView
    }()
    
    private var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        
        return stackView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = .white

        return label
    }()
    
    private var overview: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 14)
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

    // MARK: Aux
    func setupView(for movie: MoviesListItem) {
        titleLabel.text = movie.originalTitle
        poster.downloadImage(from: URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)")!)
        overview.text = movie.overview
    }
    
    private func addViews() {
        addSubview(totalStackView)
        totalStackView.addArrangedSubview(UIView())
        totalStackView.addArrangedSubview(poster)
        totalStackView.addArrangedSubview(infoStackView)
        totalStackView.addArrangedSubview(UIView())
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(separator)
        infoStackView.addArrangedSubview(overview)
    }
    
    private func buildConstraintsCell() {
        NSLayoutConstraint.activate([
            totalStackView.topAnchor.constraint(equalTo: topAnchor),
            totalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            totalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            totalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),

            poster.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.85),
            poster.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3)
        ])
    }
}
