//
//  Service.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 31/05/22.
//

import Foundation
import UIKit

class Service {
    enum MovieErrorState: Swift.Error {
        case generic
        case movieNotFound
        case noConnection
    }
    
    static func getAllMovies(_ completion: @escaping (Result<MoviesResponse, MovieErrorState>) -> Void) {
        if let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=f66bae459e0caf58012f1645bfb5e772") {
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data else { return }
             
                do {
                    let moviesAPI = try JSONDecoder().decode(MoviesResponse.self, from: data)
                    completion(.success(moviesAPI))
//                    print(moviesAPI)
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(.generic))
                }
            }
            task.resume()
        }
    }
}
