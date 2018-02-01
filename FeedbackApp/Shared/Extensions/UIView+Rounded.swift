//
//  UIView+Rounded.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(
        withRadius cornerRadius: CGFloat? = nil,
        borderWidth: CGFloat = 0,
        borderColor: UIColor? = .clear) {
        layer.borderWidth   = borderWidth
        layer.borderColor   = borderColor?.cgColor
        layer.cornerRadius  = cornerRadius ?? frame.height/2
        layer.masksToBounds = true
    }
}
