//
//  Movie.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 31/05/22.
//

import Foundation
import UIKit

struct MoviesResponse: Codable {
    let results: [MoviesResponseItem]
    let total_pages: Int
}

struct MoviesResponseItem: Codable {
    var id: Int
    let original_language: String
    let original_title: String
    let overview: String
    let poster_path: String?
    let release_date: String
    let title: String
    let genres: [Genre]?
    let genres_id: [Int]?
}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct MoviesList {
    let movies: [MoviesListItem]
}

struct MoviesListItem {
    let id: Int
    let originalTitle: String
    let overview: String
    let poster_path: String
    let release_date: String
    
    var isFavorite: Bool?
    
    init(from coreData: CoreDataMovie) {
        self.id = Int(coreData.id)
        self.originalTitle = coreData.original_title ?? ""
        self.overview = coreData.overview ?? ""
        self.poster_path = coreData.poster_path ?? ""
        self.release_date = coreData.release_date ?? ""
    }
    
    init(from response: MoviesResponseItem) {
        self.id = response.id
        self.originalTitle = response.original_title
        self.overview = response.overview
        self.poster_path = response.poster_path ?? ""
        self.release_date = response.release_date
    }
}






