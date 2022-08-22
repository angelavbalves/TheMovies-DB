//
//  Service.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 31/05/22.
//

import Foundation
import UIKit

class Service {

    static func getMovies<T: Decodable>(endpoint: Endpoint, page: Int = 1, _ completion: @escaping (Result<T, MovieErrorState>) -> Void) {

        if let url = makeUrlFrom(endpoint: endpoint) {
            let task = URLSession.shared.dataTask(with: url) { data, response, _ in
                guard let data = data else { return }

                if let response = response as? HTTPURLResponse {
                    switch response.statusCode {
                        case 200...299:
                            if let obj: T = decode(data) {
                                completion(.success(obj))
                            } else {
                                completion(.failure(.generic))
                            }
                        case 300...399:
                            return
                        case 400...499:
                            completion(.failure(.badRequest))
                            return
                        case 500...599:
                            return
                        default:
                            return
                    }
                }
            }
            task.resume()
        } else {
            completion(.failure(.generic))
        }
    }

    private static func makeUrlFrom(endpoint: Endpoint) -> URLRequest? {
        guard let url = buildUrlFrom(endpoint: endpoint) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        return urlRequest
    }

    private static func buildUrlFrom(endpoint: Endpoint) -> URL? {
        var component = URLComponents()
        component.scheme = "https"
        component.host = endpoint.host
        component.path = endpoint.path
        component.query = endpoint.token
        return component.url
    }

    private static func decode<T: Decodable>(_ data: Data) -> T? {
        do {
            let moviesAPI = try JSONDecoder().decode(T.self, from: data)
            return moviesAPI
        } catch {
            print(error)
        }
        return nil
    }
}
