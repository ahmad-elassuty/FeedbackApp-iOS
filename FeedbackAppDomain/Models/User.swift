//
//  User.swift
//  FeedbackAppDomain
//
//  Created by Ahmed Elassuty on 1/30/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

/**
 User data model is used to represent system User object.
 */
public struct User: Identifiable, Equatable {
    public let id                  : Int
    public let name                : String
    public let email               : String
    public let avatarURLString     : String
    public let feedbacks           : [Feedback]

    public init(id: Int, name: String, email: String,
                avatarURLString: String, feedbacks: [Feedback]) {
        self.id                 = id
        self.name               = name
        self.email              = email
        self.avatarURLString    = avatarURLString
        self.feedbacks          = feedbacks.sorted { $0 > $1 }
    }

    public var recentFeedback: Feedback? {
        return feedbacks.first
    }
}
