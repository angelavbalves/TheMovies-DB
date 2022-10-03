//
//  ApiEndpoint.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 18/08/22.
//

import Foundation

enum ApiEndpoints {
    case movies(page: Int)
    case similarMovies(movieId: Int, page: Int)
}

extension ApiEndpoints: Endpoint {
    var host: String {
        return "api.themoviedb.org"
    }

    var path: String {
        switch self {
            case .similarMovies(let movieId, _):
                return "/3/movie/\(movieId)/similar"
            default:
                return "/3/movie/popular"
        }
    }

    var method: String {
        return "get"
    }

    var token: String {
        switch self {
            case .movies(let page):
                return "api_key=f66bae459e0caf58012f1645bfb5e772&page=\(page)"
            case .similarMovies(_, let page):
                return "api_key=f66bae459e0caf58012f1645bfb5e772&language=en-US&page=\(page)"
        }
    }
}
