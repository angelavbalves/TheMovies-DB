//
//  Theme.swift
//  TheMoviesDB3
//
//  Created by Angela Alves on 04/10/22.
//

import Foundation
import UIKit

struct Theme {
    let colors: Colors

    struct Colors {
        let backgroudColor: Color
        let textColor: Color
        let navControllerColor: Color
        let backgroundColorCell: Color
        let tabBarColor: Color
        let itemsNav: Color
    }
}

extension Theme {
    static let currentTheme = Theme(
        colors: Colors(
            backgroudColor: .init(light: Constants.Color.pinkRed, dark: .darkGray),
            textColor: .init(light: .white, dark: .white),
            navControllerColor: .init(light: Constants.Color.reddishRose, dark: .systemGray),
            backgroundColorCell: .init(light: Constants.Color.rose, dark: .lightGray),
            tabBarColor: .init(light: Constants.Color.pinkRed, dark: .darkGray),
            itemsNav: .init(light: .black, dark: .white)
        ))
}

enum AppTheme: Int {
    case dark
    case light
    case device
}

extension AppTheme {
    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
            case .dark:
                return .dark
            case .light:
                return .light
            case .device:
                return .unspecified
        }
    }
}
