//
//  TMView.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 04/10/22.
//

import Foundation
import UIKit

class TMView: UIView {

    // MARK: Init
    init() {
        super.init(frame: .zero)
        configureSubviews()
        configureConstraints()
        backgroundColor = Theme.currentTheme.colors.backgroudColor.rawValue
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureSubviews() {}

    func configureConstraints() {}
}
