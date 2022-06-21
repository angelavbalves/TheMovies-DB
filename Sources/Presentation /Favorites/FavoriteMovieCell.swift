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
    private var poster: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
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
        addSubview(poster)
        addSubview(infoStackView)
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(separator)
        infoStackView.addArrangedSubview(overview)
    }
    
    private func buildConstraintsCell() {
        NSLayoutConstraint.activate([
            poster.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            poster.trailingAnchor.constraint(equalTo: infoStackView.leadingAnchor, constant: -4),
            poster.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            poster.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            poster.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.85),
            poster.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.3),
            
            infoStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            infoStackView.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 8),
            infoStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            infoStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            titleLabel.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -6),
        ])
    }
}
