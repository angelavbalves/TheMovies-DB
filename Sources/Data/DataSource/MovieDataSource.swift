//
//  MovieDataSource.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 31/05/22.
//

import CoreData
import Foundation
import UIKit

class MovieDataSource {

    // MARK: Init
    private init() {}

    // MARK: Properties
    static let sharedInstance = MovieDataSource()
    private var appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    private let fetchRequest = NSFetchRequest<CoreDataMovie>(entityName: "CoreDataMovie")

    // MARK: Save favorites movies in the coredata
    func saveFavoriteMovie(movie: MoviesListItem) {
        guard checkMovieInCoreDataFor(id: movie.id) == false else {
            print("❌ - Filme já está nos favoritos")
            return
        }
        guard let context = appDelegate?.container.viewContext else {
            print("❌ - Falha ao recuperar PersistentContainer (saveButtonTappede)")
            return
        }

        let newMovie = NSEntityDescription.insertNewObject(forEntityName: "CoreDataMovie", into: context)
        newMovie.setValue(movie.id, forKey: "id")
        newMovie.setValue(movie.originalTitle, forKey: "original_title")
        newMovie.setValue(movie.overview, forKey: "overview")
        newMovie.setValue(movie.poster_path, forKey: "poster_path")
        newMovie.setValue(movie.release_date, forKey: "release_date")

        do {
            try context.save()
            print("favorite movie saved")
        } catch {
            print("favorite movie not saved")
        }
    }

    // MARK: Search if the movie is already in coredata
    func checkMovieInCoreDataFor(id: Int) -> Bool {
        guard let managedContext = appDelegate?.container.viewContext else {
            print("❌ - Falha ao recuperar PersistentContainer (checkMovieInCoreData)")
            return false
        }

        let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataMovie")
        requestDel.returnsObjectsAsFaults = false

        let data = try? managedContext.fetch(requestDel)

        let movies = data as? [CoreDataMovie]

        return movies?.contains(where: { $0.id == id }) ?? false
    }

    // MARK: Remove the favorite movie from coredata
    func removeFavoriteMovie(id: Int) {
        guard let managedContext = appDelegate?.container.viewContext else {
            print("❌ - Falha ao recuperar PersistentContainer (removeMovie)")
            return
        }

        let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataMovie")
        requestDel.returnsObjectsAsFaults = false

        do {
            let data = try managedContext.fetch(requestDel)

            let movies = data as! [CoreDataMovie]

            let movieToBeRemoved = movies.first(where: { $0.id == id })

            if let movieToBeRemoved = movieToBeRemoved {
                managedContext.delete(movieToBeRemoved)
            }

        } catch {
            print("Failed")
        }

        // Saving the Delete operation
        do {
            try managedContext.save()
            print("deleted")

        } catch {
            print("Failed saving")
        }
    }

    // MARK: Remove all movies from coredata
    func removeMovie() {
        guard let managedContext = appDelegate?.container.viewContext else {
            print("❌ - Falha ao recuperar PersistentContainer (removeMovie)")
            return
        }

        do {
            let fetchedResults = try managedContext.fetch(fetchRequest)
            for movie in fetchedResults {
                managedContext.delete(movie)
            }
            try managedContext.save()
        } catch {
            print("Error")
        }
    }

    // MARK: Search all movies
    func fetchAllDataFromCoreData(completion: (_ complete: Bool, _ movies: [MoviesListItem]) -> ()) {
        guard let container = appDelegate?.container else {
            print("❌ - Falha ao recuperar PersistentContainer (fetchAllDataFromCoreData)")
            return
        }
        do {
            let fetchedResults = try container.viewContext.fetch(fetchRequest)
            let movies = MoviesList(movies: fetchedResults.map(MoviesListItem.init)).movies

            print(movies.count)
            completion(true, movies)
        } catch {
            debugPrint("Could not fetch \(error.localizedDescription)")
            completion(false, [])
        }
    }
}
