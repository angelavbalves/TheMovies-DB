//
//  MovieDetailsViewController.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 06/06/22.
//

import Foundation
import UIKit

class MovieDetailsViewController: UIViewController {

    // MARK: Properties
    private let movieDetails: MoviesListItem
    private var isSelected: Bool = false

    // MARK: Views
    private lazy var detailsView = MovieDetailsView(details: movieDetails)
    private lazy var favoriteButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(buttonSelected))

    // MARK: Init
    init(details: MoviesListItem) {
        movieDetails = details
        super.init(nibName: nil, bundle: nil)
        navigationItem.setRightBarButton(favoriteButton, animated: true)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life cycle
    override func loadView() {
        view = detailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        isSelected = MovieDataSource.sharedInstance.checkMovieInCoreDataFor(id: movieDetails.id)
        updateButtonState(isSelected: isSelected)
    }

    // MARK: Action
    @objc func buttonSelected() {
        if isSelected {
            MovieDataSource.sharedInstance.removeFavoriteMovie(id: movieDetails.id)
            updateButtonState(isSelected: false)
            isSelected = false
        } else {
            MovieDataSource.sharedInstance.saveFavoriteMovie(movie: movieDetails)
            updateButtonState(isSelected: true)
            isSelected = true
        }
    }

    // MARK: Aux
    func updateButtonState(isSelected: Bool) {
        if isSelected {
            let buttonSymbolFill = UIImage(systemName: "star.fill")
            favoriteButton.image = buttonSymbolFill
        } else {
            let buttonSymbol = UIImage(systemName: "star")
            favoriteButton.image = buttonSymbol
        }
    }
}
