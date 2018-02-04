//
//  Theme.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 2/1/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import UIKit

let minuteAgoInterval  = TimeInterval(-1 * 60)
let hourAgoInterval    = 60 * minuteAgoInterval
let dayAgoInterval     = 24 * hourAgoInterval
let monthAgoInterval   = 30 * dayAgoInterval
let yearAgoInterval    = 12 * monthAgoInterval

/**
 Global application theme configurations
 */
enum Theme {}

// MARK: - Navigation controller theme properties
extension Theme {
    static var navigationBarTintColor: UIColor {
        return #colorLiteral(red: 0.1411764706, green: 0.3254901961, blue: 0.5294117647, alpha: 1)
    }

    static var navigationBarTitleTextColor: UIColor {
        return #colorLiteral(red: 0.1411764706, green: 0.3254901961, blue: 0.5294117647, alpha: 1)
    }

    static func configure(_ navigationController: UINavigationController) {
        let navigationBar = navigationController.navigationBar
        navigationBar.tintColor = navigationBarTintColor

        let titleAttributes: [NSAttributedStringKey: Any] = [
            .foregroundColor: navigationBarTitleTextColor
        ]

        if #available(iOS 11.0, *) {
            navigationBar.largeTitleTextAttributes = titleAttributes
        }
    }
}

// MARK: -
extension Theme {
    /**
     Represents different date groups to provide
     the visual properties of the input date
     */
    enum DateCategory {
        case
        lessThanMonth,
        lessThanYear,
        moreThanYear

        var color: UIColor {
            switch self {
            case .lessThanMonth:
                return #colorLiteral(red: 0, green: 0.3921568627, blue: 0, alpha: 1)
            case .lessThanYear:
                return #colorLiteral(red: 0.9843137255, green: 0.6784313725, blue: 0.2549019608, alpha: 1)
            case .moreThanYear:
                return #colorLiteral(red: 0.7529411765, green: 0.2235294118, blue: 0.168627451, alpha: 1)
            }
        }

        init?(date: Date?) {
            guard let date = date else {
                return nil
            }

            let now = Date()
            let monthAgo = now.addingTimeInterval(monthAgoInterval)
            let yearAgo = now.addingTimeInterval(yearAgoInterval)

            switch date {
            case _ where date > monthAgo:
                self = .lessThanMonth
            case _ where date > yearAgo:
                self = .lessThanYear
            default:
                self = .moreThanYear
            }
        }
    }
}
