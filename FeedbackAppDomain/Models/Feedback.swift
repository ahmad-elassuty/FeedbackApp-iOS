//
//  Feedback.swift
//  FeedbackAppDomain
//
//  Created by Ahmed Elassuty on 1/30/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

/**
 Feedback data model is used to represent system Feedback object.
 */
public struct Feedback: Identifiable, Equatable {
    public let id  : Int
    public let date: Date

    public init(id: Int, date: Date) {
        self.id     = id
        self.date   = date
    }
}

extension Feedback: Comparable {
    public static func < (lhs: Feedback, rhs: Feedback) -> Bool {
        return lhs.date < rhs.date
    }
}
