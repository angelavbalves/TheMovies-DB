//
//  MoviesFavoritesView.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 10/06/22.
//

import Foundation
import UIKit

class MoviesFavoritesView: UIView, UITableViewDelegate, UITableViewDataSource  {
    var filteredMovies: [MoviesListItem] = []
    var delegate: FavoritesMoviesDelegate?
    var delegateDetails: MovieListDelegate?
    
    private lazy var tableView: UITableView = {
        let cv =  UITableView(frame: .zero, style: UITableView.Style.plain)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    init(delegate: MovieListDelegate) {
        delegateDetails = delegate
        super.init(frame: .zero)
        setupTableView()
        constraintsTableView()
        tableView.register(MovieFavoriteCell.self, forCellReuseIdentifier: MovieFavoriteCell.identifer)
        tableView.backgroundColor = Constants.Color.pinkRed
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCellFavorite", for: indexPath) as! MovieFavoriteCell
        let movie = filteredMovies[indexPath.row]
        cell.setupView(for: movie)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 200
        addSubview(tableView)
    }
    
    
    func constraintsTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo:topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
