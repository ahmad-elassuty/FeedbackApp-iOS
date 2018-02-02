//
//  UIView+Constraints.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 2/2/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import UIKit

extension UIView {
    func pinViewToEdges(_ view: UIView) {
        let constraints = [
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
