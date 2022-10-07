//
//  Endpoint.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 18/08/22.
//

import Foundation

protocol Endpoint {
    var host: String { get }
    var method: String { get }
    var path: String { get }
//    var token: String { get }
//    var textSearch: String? { get }
    var query: [URLQueryItem] { get }
}
