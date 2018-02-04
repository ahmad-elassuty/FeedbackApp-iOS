//
//  ColleagueProfileInteractorSpec.swift
//  FeedbackAppTests
//
//  Created by Ahmed Elassuty on 2/3/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import Quick
import Nimble
import FeedbackAppDomain
@testable import FeedbackApp

class ColleaguesProfileInteractorSpec: QuickSpec {
    override func spec() {
        var presenterMock   : ColleagueProfilePresenterMock!
        var interactor      : ColleagueProfileInteractor!

        let request  = ColleagueProfile.Fetch.Request()

        describe("Colleague Profile Interactor") {
            context("when receives request") {
                beforeEach {
                    presenterMock       = ColleagueProfilePresenterMock()
                    interactor          = ColleagueProfileInteractor(presenter: presenterMock)
                    interactor.user     = userWith5MonthsAgoFeedback
                    interactor.fetchColleagueProfile(request)
                }

                it("should eventually call present fetched colleagues") {
                    expect(presenterMock.presentFetchedColleagueCalled).toEventually(beTrue())

                    let resultUser = presenterMock.response!.value!
                    XCTAssert(resultUser == userWith5MonthsAgoFeedback)
                }
            }
        }
    }
}
