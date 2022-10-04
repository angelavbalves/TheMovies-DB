//
//  MovieErrorState.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 18/08/22.
//

import Foundation

enum MovieErrorState: Swift.Error {
    case generic
    case clientError
    case noConnection
    case serverError
    case redirectError
}
