//
//  ColleaguesListInteractorSpec.swift
//  FeedbackAppTests
//
//  Created by Ahmed Elassuty on 2/4/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import Quick
import Nimble
@testable import FeedbackApp

class ColleaguesListInteractorSpec: QuickSpec {
    override func spec() {
        let view = ColleaguesListDisplayViewMock()
        var presenter: ColleaguesListPresenterMock!
        var interactor: ColleaguesListInteractor!

        describe("Colleagues List Interactor") {
            describe("Fetch colleagues") {
                let request = ColleaguesList.Fetch.Request()

                beforeEach {
                    presenter = ColleaguesListPresenterMock(displayView: view)
                    interactor = ColleaguesListInteractor(presenter: presenter)
                    interactor.fetch(request)
                }

                it("should eventually call the presenter") {
                    expect(presenter.presentFetchedColleaguesCalled)
                        .toEventually(beTrue())
                }

                it("should return array of users to the presenter") {
                    expect(presenter.colleaguesResponse?.value)
                        .toEventuallyNot(beNil())
                }
            }

            describe("Give feedback") {
                let request = ColleaguesList.GiveFeedback.Request(
                    userId: userWith5MonthsAgoFeedbackId
                )

                beforeEach {
                    presenter = ColleaguesListPresenterMock(displayView: view)
                    interactor = ColleaguesListInteractor(presenter: presenter)
                    interactor.users = [userWith5MonthsAgoFeedback]
                }

                it("should add new feedback to the user") {
                    expect(interactor.users[0].feedbacks).to(haveCount(1))

                    interactor.giveFeedback(request)

                    expect(interactor.users[0].feedbacks)
                        .toEventually(haveCount(2))
                }
            }
        }
    }
}
