//
//  THViewController.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 01/08/22.
//

import Foundation
import UIKit
import TinyConstraints

class TMViewController: UIViewController {

    // MARK: - Properties
    var isDark = false
    let loadingView = TMLoadingView()
    let errorView = TMErrorView()
    let emptyView = TMEmptyView()
    var defaults = UserDefaults.standard
    var appTheme: AppTheme {
        get {
            return defaults.appTheme
        }
        set {
            defaults.appTheme = newValue
            configureStyle(for: newValue)
        }
    }

    // MARK: -  Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureNavController()
    }

    // MARK: - Aux
    func configureViews() {
        view.backgroundColor = Theme.currentTheme.colors.backgroudColor.rawValue
        view.addSubview(loadingView)
        view.addSubview(errorView)
        view.addSubview(emptyView)
        loadingView.edgesToSuperview()
        errorView.edgesToSuperview()
        emptyView.edgesToSuperview()
    }

    func configureNavController() {
        navigationController?.navigationBar.tintColor = Theme.currentTheme.colors.itemsNav.rawValue
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = Theme.currentTheme.colors.navControllerColor.rawValue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    func configureStyle(for theme: AppTheme) {
        view.window?.overrideUserInterfaceStyle = appTheme.userInterfaceStyle
    }
}
