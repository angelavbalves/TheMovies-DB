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
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.barTintColor = .label
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

        viewControllers = [
            createNavControllers(for: popularMovies, title: "Home", image: UIImage(named: "list_icon")!)
        ]
        
    }
}
