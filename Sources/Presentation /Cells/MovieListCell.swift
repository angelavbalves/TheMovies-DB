//
//  MovieListCell.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 31/05/22.
//

import Foundation
import UIKit

class MovieListCell: UICollectionViewCell {
    static let identifer = "idCellHome"
    var id: Int = 0
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    var stackViewCell: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical

        return stackView
    }()

    var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal

        return stackView
    }()

    var titleMovie: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()

    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setContentHuggingPriority(.required, for: .horizontal)
        let buttonImage = UIImage(named: "favorite_empty_icon")

        button.setImage(buttonImage, for: .normal)

//        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviewsCell()
        buildCellConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        backgroundColor = Constants.Color.rose
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func buildCellConstraints() {
        NSLayoutConstraint.activate([
            stackViewCell.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackViewCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            stackViewCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            stackViewCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),

            imageView.heightAnchor.constraint(equalToConstant: frame.height * 0.75),

        ])
    }

    func addSubviewsCell() {
        addSubview(stackViewCell)
        stackViewCell.addArrangedSubview(imageView)
        stackViewCell.addArrangedSubview(titleStackView)

        titleStackView.addArrangedSubview(titleMovie)
        titleStackView.addArrangedSubview(favoriteButton)
    }

    func setup(for movie: MoviesListItem) {
        titleMovie.text = movie.originalTitle
        imageView.downloadImage(from: URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)")!)
        id = Int(movie.id)
    }
}

extension UICollectionView {
    func indexPathForCellContaining(view: UIView) -> IndexPath? {
        let viewCenter = convert(view.center, from: view.superview)
        return indexPathForItem(at: viewCenter)
    }
}

extension UIImageView {
    func downloadImage(from url: URL) {
        let session = URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
            }
        }
        session.resume()
    }
}
