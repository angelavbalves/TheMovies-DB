//
//  TMErrorView.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 03/10/22.
//

import Foundation
import TinyConstraints
import UIKit

class TMErrorView: TMView {

    // MARK: - Properties
    var retryAction: (() -> Void)?

    // MARK: - Init
    override init() {
        super.init()
        backgroundColor = Theme.currentTheme.colors.backgroundColorCell.rawValue
        isHidden = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.tintColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let refreshButton: UIButton = {
        let button = UIButton()
        button.setTitle("Try again", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(retryButtonTappedAction), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 8
        button.layer.masksToBounds = false
        return button
    }()

    // MARK: - Aux
    override func configureSubviews() {
        addSubview(totalStackView)
        totalStackView.addArrangedSubview(imageView)
        totalStackView.addArrangedSubview(errorLabel)
        totalStackView.addArrangedSubview(refreshButton)
    }

    override func configureConstraints() {
        totalStackView.centerInSuperview(usingSafeArea: true)
        refreshButton.width(180)
        imageView.heightToWidth(of: imageView)
    }

    func show(_ error: MovieErrorState, retryAction: (() -> Void)?) {
        self.retryAction = retryAction
        switch error {
            case .clientError:
                buildForClientError()
            case .noConnection:
                buildForNoConnection()
            case .generic:
                buildForGeneric()
            case .serverError:
                buildForServerError()
            case .redirectError:
                buildForRedirectError()
        }
    }

    func hide() {
        isHidden = true
    }

    @objc func retryButtonTappedAction() {
        retryAction?()
        hide()
    }

    func buildForClientError() {
        imageView.image = UIImage(named: "error404")!
        isHidden = false
    }

    func buildForNoConnection() {
        imageView.image = UIImage(named: "noConnection")
        errorLabel.text = "No internet connection"
        isHidden = false
    }

    func buildForGeneric() {
        imageView.image = UIImage(named: "errorImage")
        errorLabel.text = "Oops, something went wrong here!"
        isHidden = false
    }

    func buildForServerError() {
        imageView.image = UIImage(named: "serverError")
        errorLabel.text = "Oops, we had some server problem here!"
        isHidden = false
    }

    func buildForRedirectError() {
        imageView.image = UIImage(named: "error300")
        errorLabel.text = "Oops, there is some redirect problem!"
        isHidden = false
    }
}
