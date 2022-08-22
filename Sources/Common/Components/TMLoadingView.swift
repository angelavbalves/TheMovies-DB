//
//  THLoadingView.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 01/08/22.
//

import Foundation
import UIKit

class TMLoadingView: UIView {

    // MARK: Init
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        addActiveIndicator()
        setupConstraints()
        isHidden = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View
    let activeIndicator = UIActivityIndicatorView(style: .large)

    // MARK: Aux
    private func addActiveIndicator() {
        addSubview(activeIndicator)
    }

    private func setupConstraints() {
        activeIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activeIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activeIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
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
