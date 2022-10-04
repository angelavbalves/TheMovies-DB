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
    var loadingView = TMLoadingView()
    var errorView = TMErrorView()

    // MARK: -  Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }

    // MARK: - Aux
    func configureViews() {
        view.addSubview(loadingView)
        view.addSubview(errorView)
        loadingView.edgesToSuperview()
        errorView.edgesToSuperview()
    }
}
