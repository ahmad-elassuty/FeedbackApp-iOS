//
//  ColleagueListPresenterSpec.swift
//  FeedbackAppTests
//
//  Created by Ahmed Elassuty on 2/3/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import Quick
import Nimble
@testable import FeedbackApp

class ColleaguesListPresenterSpec: QuickSpec {
    override func spec() {
        var viewMock: ColleaguesListDisplayViewMock!
        var presenter: ColleaguesListPresenter!

        describe("Colleagues list presenter") {
            beforeEach {
                viewMock = ColleaguesListDisplayViewMock()
                presenter = ColleaguesListPresenter(displayView: viewMock)
            }

            describe("Fetch colleagues") {
                let successfullFetchResponse    = ColleaguesList.Fetch.Response(value: [userWith5MonthsAgoFeedback, userWithRecentFeedback])

                let fetchError                  = ColleaguesUseCaseError.fetchColleaguesError("Error")
                let failedFetchResponse         = ColleaguesList.Fetch.Response(error: fetchError)

                context("when receives success response") {
                    beforeEach {
                        presenter.presentFetchedColleagues(successfullFetchResponse)
                    }

                    it("should call did fetch of the display view") {
                        expect(viewMock.didFetchCalled).toEventually(beTrue())
                        expect(viewMock.didFetchViewModel).toNot(beNil())

                        expect(viewMock.failedToFetchCalled).to(beFalse())
                        expect(viewMock.failedToFetchError).to(beNil())
                    }

                    it("should return list of colleagues") {
                        // Make sure that we wait for the data to be avaliable
                        expect(viewMock.didFetchViewModel?.colleagues).toEventually(haveCount(2))

                        let colleagues = viewMock.didFetchViewModel?.colleagues
                        let recentlyInteractedWithSection       = colleagues!.last!
                        let didNotInteractWithRecentlySection   = colleagues!.first!

                        expect(didNotInteractWithRecentlySection).to(haveCount(1))
                        expect(recentlyInteractedWithSection).to(haveCount(1))

                        XCTAssert(didNotInteractWithRecentlySection.first! == userWith5MonthsAgoFeedback)
                        XCTAssert(recentlyInteractedWithSection.first! == userWithRecentFeedback)
                    }
                }

                context("when receives error response") {
                    beforeEach {
                        presenter.presentFetchedColleagues(failedFetchResponse)
                    }

                    it("should call failed to fetch of the display view") {
                        expect(viewMock.failedToFetchCalled).toEventually(beTrue())
                        expect(viewMock.didFetchCalled).to(beFalse())
                    }

                    it("should return error") {
                        expect(viewMock.failedToFetchError).toEventuallyNot(beNil())
                        expect(viewMock.failedToFetchError).to(matchError(ColleaguesUseCaseError.self))
                    }
                }
            }

            describe("Give feedback") {
                let successfullGiveFeedbackResponse = ColleaguesList.GiveFeedback.Response(value: userWith5MonthsAgoFeedback)
                let giveFeedbackError               = ColleaguesUseCaseError.giveColleagueFeedbackError("Error")
                let failedToGiveFeedbackResponse    = ColleaguesList.GiveFeedback.Response(error: giveFeedbackError)

                context("when receives success response") {
                    beforeEach {
                        presenter.presentGiveFeedback(successfullGiveFeedbackResponse)
                    }

                    it("should call did give feedback of the display view") {
                        expect(viewMock.didGiveFeedbackCalled).toEventually(beTrue())
                        expect(viewMock.didGiveFeedbackViewModel).toNot(beNil())

                        expect(viewMock.failedToGiveFeedbackCalled).to(beFalse())
                        expect(viewMock.failedToGiveFeedackError).to(beNil())
                    }

                    it("should return the new colleague") {
                        // Make sure that we wait for the data to be avaliable
                        expect(viewMock.didGiveFeedbackViewModel?.colleague).toEventuallyNot(beNil())

                        let colleague = viewMock.didGiveFeedbackViewModel!.colleague
                        XCTAssert(colleague == userWith5MonthsAgoFeedback)
                    }
                }

                context("when receives error response") {
                    beforeEach {
                        presenter.presentGiveFeedback(failedToGiveFeedbackResponse)
                    }

                    it("should call failed to give feedback of the display view") {
                        expect(viewMock.failedToGiveFeedbackCalled).toEventually(beTrue())
                        expect(viewMock.didGiveFeedbackCalled).to(beFalse())
                    }

                    it("should return error") {
                        expect(viewMock.failedToGiveFeedackError).toEventuallyNot(beNil())
                        expect(viewMock.failedToGiveFeedackError).to(matchError(ColleaguesUseCaseError.self))
                    }
                }
            }
        }
    }
}
