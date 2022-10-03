//
//  THLoadingView.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 01/08/22.
//

import Foundation
import UIKit
import TinyConstraints

class TMLoadingView: UIView {

    // MARK: - Init
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupView()
        isHidden = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View
    let activeIndicator = UIActivityIndicatorView(style: .large)

    // MARK: - Aux
    private func setupView() {
        addSubview(activeIndicator)
        activeIndicator.centerInSuperview()
    }

    func show() {
        isHidden = false
        activeIndicator.startAnimating()
    }

    func hide() {
        isHidden = true
        activeIndicator.stopAnimating()
    }
}
