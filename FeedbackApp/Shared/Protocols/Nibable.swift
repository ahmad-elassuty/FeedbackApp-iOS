//
//  Nibable.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 2/4/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import Foundation

protocol Nibable {}

extension Nibable {
    var defaultNibName: String {
        return String(describing: type(of: self))
    }
}
