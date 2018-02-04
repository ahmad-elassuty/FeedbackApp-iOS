//
//  Equatable.swift
//  FeedbackAppTests
//
//  Created by Ahmed Elassuty on 2/4/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import FeedbackAppDomain
@testable import FeedbackApp

// Exactly match
extension Feedback {
    static func ==(lhs: Feedback, rhs: Feedback) -> Bool {
        return lhs.id == rhs.id &&
            lhs.date == rhs.date
    }
}

// Exactly match
extension User {
    static func ==(lhs: User, rhs: User) -> Bool {
        let equalFeedbacksSizes = lhs.feedbacks.count == rhs.feedbacks.count
        let equalFeedbacks = zip(lhs.feedbacks, rhs.feedbacks).reduce(true) { $0 && $1.0 == $1.1 }

        return lhs.id == rhs.id &&
            lhs.email == rhs.email &&
            lhs.name == rhs.name &&
            lhs.avatarURLString == rhs.avatarURLString &&
            equalFeedbacksSizes &&
        equalFeedbacks
    }
}

extension ColleagueProfile.Feedback: Equatable {
    public static func ==(lhs: ColleagueProfile.Feedback, rhs: ColleagueProfile.Feedback) -> Bool {
        return lhs.dateCategory == rhs.dateCategory &&
            lhs.dateString == rhs.dateString
    }
}

extension ColleagueProfile.Colleague: Equatable {
    public static func ==(lhs: ColleagueProfile.Colleague, rhs: ColleagueProfile.Colleague) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.feedbacks == rhs.feedbacks &&
            lhs.avatarURL == rhs.avatarURL
    }
}

extension ColleaguesList.Colleague {
    static func == (lhs: ColleaguesList.Colleague, rhs: User) -> Bool {
        let equalRecentFeedbacks: Bool

        let lhsRecentStrDate = lhs.lastFeedbackDateString
        let rhsRecentStrDate = rhs.recentFeedback?.date.timeAgoString

        switch (lhsRecentStrDate, rhsRecentStrDate) {
        case (.none, .none):
            equalRecentFeedbacks = true
        case (.some, .some):
            equalRecentFeedbacks = lhsRecentStrDate! == rhsRecentStrDate
        default:
            equalRecentFeedbacks = false
        }

        return lhs.id == rhs.id &&
            lhs.name == rhs.name.capitalized &&
            equalRecentFeedbacks &&
            lhs.avatarURL == URL(string: rhs.avatarURLString ?? "")
    }
}
