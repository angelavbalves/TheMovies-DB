//
//  MovieDetailsView.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 06/06/22.
//

import Foundation
import UIKit

class MovieDetailsView: UIView {
    let movieDetails: MoviesListItem
    
    var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22)
        label.numberOfLines = 0
        label.textColor = .white
        label.text = "Title Movie"
        
        return label
    }()
    
    func addViews() {
        addSubview(title)
    }
    
    func buildConstraintsView() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            title.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.6),
            title.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
    }
    
    init(details: MoviesListItem) {
        movieDetails = details
        super.init(frame: .zero)
        backgroundColor = Constants.Color.pinkRed
        addViews()
        buildConstraintsView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
