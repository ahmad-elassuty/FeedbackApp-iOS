//
//  FSUser.swift
//  FeedbackAppFileStore
//
//  Created by Ahmed Elassuty on 1/30/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import Marshal
import FeedbackAppDomain

struct FSUser: Unmarshaling {
    let id              : Int
    let name            : String
    let email           : String
    let avatarURLString : String?
    let feedbacks       : [FSFeedback]

    init(object: MarshaledObject) throws {
        id              = try object.value(for: "id")
        name            = try object.value(for: "name")
        email           = try object.value(for: "email")
        avatarURLString = try object.value(for: "avatar")
        feedbacks       = try object.value(for: "last_interactions")
    }

    func asDomainUser() -> User {
        return User(
            id: id, name: name, email: email,
            avatarURLString: avatarURLString,
            feedbacks: feedbacks.map { $0.asDomainFeedback() }
        )
    }
}
