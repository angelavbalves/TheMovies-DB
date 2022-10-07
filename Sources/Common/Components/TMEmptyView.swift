//
//  TMEmptyView.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 07/10/22.
//

import Foundation
import UIKit

class TMEmptyView: TMView {

    // MARK: Init
    override init() {
        super.init()
        backgroundColor = Theme.currentTheme.colors.backgroundColorCell.rawValue
        isHidden = true
    }

    // MARK: Views
    private var totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center

        return stackView
    }()

    private var emptyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.required, for: .vertical)

        return imageView
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.tintColor = .gray
        label.numberOfLines = 0

        return label
    }()

    // MARK: Aux
    override func configureSubviews() {
        addSubview(totalStackView)
        totalStackView.addArrangedSubview(emptyImage)
        totalStackView.addArrangedSubview(titleLabel)
    }

    override func configureConstraints() {
        totalStackView.centerInSuperview(usingSafeArea: true)
        emptyImage.heightToWidth(of: emptyImage)
    }

    func show(title: String, image: UIImage) {
        titleLabel.text = title
        emptyImage.image = image
        isHidden = false
    }

    func hide() {
        isHidden = true
    }
}
