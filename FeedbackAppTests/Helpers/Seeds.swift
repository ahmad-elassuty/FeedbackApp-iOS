//
//  Seeds.swift
//  FeedbackAppTests
//
//  Created by Ahmed Elassuty on 2/3/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import Foundation
import FeedbackAppDomain
@testable import FeedbackApp

fileprivate let name                    = "Test User"
fileprivate let email                   = "test@test.com"
fileprivate let avatar: String?         = nil
fileprivate let oldDate                 = Date(timeInterval: -5 * 30 * 24 * 60 * 60, since: Date())
fileprivate let feedback                = Feedback(id: 1, date: oldDate)
fileprivate let feedbacks: [Feedback]   = [feedback]

fileprivate let newDate                         = Date()
fileprivate let recentFeedback                  = Feedback(id: 2, date: newDate)
fileprivate let recentFeedbacks: [Feedback]     = [recentFeedback]

let colleagueProfileFeedback2 = ColleagueProfile.Feedback(
    dateCategory: Theme.DateCategory.lessThanYear,
    dateString: oldDate.timeAgoString
)

let userWith5MonthsAgoFeedback = User(
    id: 1, name: name, email: email + "1",
    avatarURLString: avatar, feedbacks: feedbacks
)

let userWithRecentFeedback = User(
    id: 2, name: name, email: email + "2",
    avatarURLString: avatar, feedbacks: recentFeedbacks
)

let colleagueProfile = ColleagueProfile.Colleague(
    id: 1, name: name, avatarURL: URL(string: avatar ?? ""),
    feedbacks: [colleagueProfileFeedback2]
)

let minuteInterval  = TimeInterval(-1 * 60)
let hourInterval    = 60 * minuteInterval
let dayInterval     = 24 * hourInterval
let monthInterval   = 31 * dayInterval
let yearInterval    = 12 * monthInterval
