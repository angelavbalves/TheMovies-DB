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
}

struct MoviesResponseItem: Codable {
    let adult: Bool
    let backdrop_path: String
    let genre_ids: [Int]
    var id: Int? = 0
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Float
    let poster_path: String
    let release_date: String
    let title: String
    let video: Bool
    let vote_count: Int
    let vote_average: Float
}


struct MoviesList {
    let movies: [MoviesListItem]
}

struct MoviesListItem {
    let id: Int64
    let originalTitle: String
    let overview: String
    let poster_path: String
    let release_date: String
    
    init(from coreData: CoreDataMovie) {
        self.id = coreData.id
        self.originalTitle = coreData.original_title ?? ""
        self.overview = coreData.overview ?? ""
        self.poster_path = coreData.poster_path ?? ""
        self.release_date = coreData.release_date ?? ""
    }
}

