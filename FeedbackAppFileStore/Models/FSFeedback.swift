//
//  FSFeedback.swift
//  FeedbackAppFileStore
//
//  Created by Ahmed Elassuty on 1/30/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import FeedbackAppDomain
import Marshal

struct FSFeedback: Unmarshaling {
    let id  : Int
    let date: Date

    public init(object: MarshaledObject) throws {
        id   = try object.value(for: "id")
        date = try object.value(for: "date")
    }

    func asDomainFeedback() -> Feedback {
        return Feedback(id: id, date: date)
    }
}
