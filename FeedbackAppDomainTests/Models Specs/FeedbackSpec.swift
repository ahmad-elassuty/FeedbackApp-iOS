//
//  FeedbackSpec.swift
//  FeedbackAppDomainTests
//
//  Created by Ahmed Elassuty on 1/30/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import Quick
import Nimble
import FeedbackAppDomain

class FeedbackSpec: QuickSpec {
    override func spec() {
        describe("Feedback Model") {
            let id              = 1
            let feedbackDate    = Date()
            var feedback: Feedback!

            beforeEach {
                feedback = Feedback(id: id, date: feedbackDate)
            }

            context("when initialized") {
                it("should have same values passed to initializer.") {
                    expect(feedback.id).to(equal(id))
                    expect(feedback.date).to(equal(feedbackDate))
                }
            }

            context("when compared") {
                let oldFeedback = Feedback(id: 2, date: feedbackDate.addingTimeInterval(-10))
                it("should be greater than older feedback.") {
                    expect(feedback).to(beGreaterThan(oldFeedback))
                }
            }

            context("when equated") {
                let anyDate             = feedbackDate.addingTimeInterval(-100)
                let differentFeedback   = Feedback(id: 2, date: anyDate)
                let sameFeedback = Feedback(id: id, date: anyDate)

                it("should be equatable based on the id.") {
                    expect(feedback).toNot(equal(differentFeedback))
                    expect(feedback).to(equal(sameFeedback))
                }
            }
        }
    }
}
