//
//  UserSpec.swift
//  FeedbackAppDomainTests
//
//  Created by Ahmed Elassuty on 1/30/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import Quick
import Nimble
import FeedbackAppDomain

class UserSpec: QuickSpec {
    override func spec() {
        describe("User Model") {
            let id              = 1
            let name            = "Test User"
            let email           = "test@impraise.com"
            let avatarURLString = """
                                    https://s3.amazonaws.com/uifaces/\
                                    faces/twitter/sauro/128.jpg
                                    """
            let now                 = Date()
            let oldFeedback         = Feedback(id: 1, date: now.addingTimeInterval(-60))
            let mostRecentFeedback  = Feedback(id: 2, date: now)
            let feedbacks           = [oldFeedback, mostRecentFeedback]

            var user: User!

            beforeEach {
                user = User(
                    id: id, name: name, email: email,
                    avatarURLString: avatarURLString,
                    feedbacks: feedbacks
                )
            }

            context("when initialized") {
                it("should have same values passed to initializer.") {
                    expect(user.id).to(equal(id))
                    expect(user.name).to(equal(name))
                    expect(user.email).to(equal(email))
                    expect(user.avatarURLString).to(equal(avatarURLString))
                }

                it("should have two feedbacks.") {
                    expect(user.feedbacks.count).to(equal(2))
                }
            }

            context("feedbacks property") {
                it("should be sorted from most recent to oldest feedback.") {
                    expect(user.feedbacks).to(equal([mostRecentFeedback, oldFeedback]))
                }
            }

            context("recentFeedback property") {
                it("should return the most recent feedback.") {
                    expect(user.recentFeedback).to(equal(mostRecentFeedback))
                }
            }

            context("give user feedback") {
                it("should prepend the new feedback") {
                    let feedback = Feedback(id: 10, date: Date())

                    user.giveFeedback(feedback)

                    expect(user.recentFeedback).to(equal(feedback))
                }

                it("should ignore outdated feedback") {
                    let oldDate = oldFeedback.date.addingTimeInterval(-60)
                    let feedback = Feedback(id: 10, date: oldDate)

                    user.giveFeedback(feedback)

                    expect(user.recentFeedback).toNot(equal(feedback))
                    expect(user.feedbacks.count).to(equal(feedbacks.count))
                }
            }
        }
    }
}
