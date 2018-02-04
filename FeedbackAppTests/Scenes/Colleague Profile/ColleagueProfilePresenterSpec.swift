//
//  ColleagueProfilePresenterSpec.swift
//  FeedbackAppTests
//
//  Created by Ahmed Elassuty on 2/3/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import Quick
import Nimble
import FeedbackAppDomain
@testable import FeedbackApp

class ColleaguesProfilePresenterSpec: QuickSpec {
    override func spec() {
        var viewMock: ColleagueProfileDisplayViewMock!
        var presenter: ColleagueProfilePresenter!

        let error = ColleaguesUseCaseError.fetchColleagueProfileError("Error")
        let successResponse  = ColleagueProfile.Fetch.Response(value: userWith5MonthsAgoFeedback)
        let failureResponse  = ColleagueProfile.Fetch.Response(error: error)

        describe("Colleague Profile Presenter") {
            context("when receives success response") {
                beforeEach {
                    viewMock = ColleagueProfileDisplayViewMock()
                    presenter = ColleagueProfilePresenter(displayView: viewMock)
                    presenter.presentFetchedColleague(response: successResponse)
                }

                it("should call did fetch of the display view") {
                    expect(viewMock.didFetchCalled).to(beTrue())
                    expect(viewMock.failedToFetchCalled).to(beFalse())
                }

                it("should return colleague") {
                    expect(viewMock.didFetchViewModel).toNot(beNil())
                    expect(viewMock.didFetchViewModel?.colleague).to(equal(colleagueProfile))
                }
            }

            context("when receives error response") {
                beforeEach {
                    viewMock = ColleagueProfileDisplayViewMock()
                    presenter = ColleagueProfilePresenter(displayView: viewMock)
                    presenter.presentFetchedColleague(response: failureResponse)
                }

                it("should call failed to fetch of the display view") {
                    expect(viewMock.failedToFetchCalled).to(beTrue())
                    expect(viewMock.didFetchCalled).to(beFalse())
                }

                it("should return error") {
                    expect(viewMock.error).toNot(beNil())
                    expect(viewMock.error).to(matchError(ColleaguesUseCaseError.self))
                }
            }
        }
    }
}
