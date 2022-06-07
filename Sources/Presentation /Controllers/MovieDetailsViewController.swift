//
//  MovieDetailsViewController.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 06/06/22.
//

import Foundation
import UIKit

class MovieDetailsViewController: UIViewController {
    
    let movieDetails: MoviesListItem
    lazy var detailsView = MovieDetailsView(details: movieDetails)
    
    init(details: MoviesListItem) {
        movieDetails = details
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = detailsView
    }
}


