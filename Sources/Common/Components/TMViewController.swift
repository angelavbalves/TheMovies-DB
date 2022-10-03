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

    // MARK: Properties
    var loadingView = TMLoadingView()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    // MARK: Aux
    func configureView() {
        view.addSubview(loadingView)
        loadingView.edgesToSuperview()
    }
}
