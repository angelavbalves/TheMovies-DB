//
//  MovieDataSource.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 31/05/22.
//

import Foundation
import UIKit
import CoreData

class MovieDataSource {
    
    static let sharedInstance = MovieDataSource()
    private init() {}
    
    var appDelegate: AppDelegate? = {
        UIApplication.shared.delegate as? AppDelegate
    }()
    let fetchRequest = NSFetchRequest<CoreDataMovie>(entityName: "CoreDataMovie")
    var filteredMovies: [MoviesListItem] = []
    
    
    
    func saveDataOf(movies: [MoviesResponseItem]) {
        guard let container = appDelegate?.container else {
            print("❌ - Falha ao recuperar PersistentContainer (saveDataOf)")
            return
        }
        let managedContext = container.viewContext
        removeMovie()
        for movie in movies {
            let newMovie = CoreDataMovie(context: managedContext)
            newMovie.setValue(movie.id, forKey: "id")
            newMovie.setValue(movie.original_title, forKey: "original_title")
            newMovie.setValue(movie.overview, forKey: "overview")
            newMovie.setValue(movie.poster_path, forKey: "poster_path")
            newMovie.setValue(movie.release_date, forKey: "release_date")
        }
        
        do {
            try managedContext.save()
        } catch {
            print("Error - SaveDataOf")
        }
//        container.performBackgroundTask { (context) in
//            self.saveDataToCoreData(movies: movies, context: context)
//        }
    }
    
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
    
    func fetchAllDataFromCoreData(completion: (_ complete: Bool, _ movies: [MoviesListItem]) -> ()) {
        guard let container = appDelegate?.container else {
            print("❌ - Falha ao recuperar PersistentContainer (fetchAllDataFromCoreData)")
            return
        }
        do {
            let fetchedResults = try container.viewContext.fetch(fetchRequest)
            let movies = MoviesList.init(movies: fetchedResults.map(MoviesListItem.init)).movies

            print(movies.count)
            completion(true, movies)
        } catch {
            debugPrint("Could not fetch \(error.localizedDescription)")
            completion(false, [])
        }
    }
}

enum MovieDataSourceError: Equatable, Error {
    case CannotSave(String = "Não foi possível salvar o filme nos favoritos. Tente novamente.")
    case CannotFind(String = "O filme não foi encontrado.")
    case CannotRemove(String = "Não foi possível remover o filme. Tente novamente.")
    case CannotFetch(String = "Não foi possível obter a lista de filmes.")
}
