//
//  MovieErrorState.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 18/08/22.
//

import Foundation

enum MovieErrorState: Swift.Error {
    case generic
    case movieNotFound
    case noConnection
    case badRequest
}
