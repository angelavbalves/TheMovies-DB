//
//  TabBar.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 31/05/22.
//

import Foundation
import UIKit


class TabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.currentTheme.colors.tabBarColor.rawValue
        tabBar.tintColor = Theme.currentTheme.colors.textColor.rawValue
        UITabBar.appearance().barTintColor = Theme.currentTheme.colors.tabBarColor.rawValue
        setupViewControllers()
    }
    
    private func createNavControllers(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        return navController
    }
    
    func setupViewControllers() {
        let popularMovies = MovieListCollectionViewController()
        let favoritesMovies = FavoritesMoviesViewController()

        viewControllers = [
            createNavControllers(for: popularMovies, title: "Home", image: UIImage(systemName: "house.fill")!),
            createNavControllers(for: favoritesMovies, title: "Favorites", image: UIImage(systemName: "star.circle")!)
        ]
        
    }
}
