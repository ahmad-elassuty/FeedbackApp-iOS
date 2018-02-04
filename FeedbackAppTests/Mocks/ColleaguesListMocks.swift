//
//  ColleaguesListMocks.swift
//  FeedbackAppTests
//
//  Created by Ahmed Elassuty on 2/4/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import FeedbackAppDomain
@testable import FeedbackApp

class ColleaguesListDisplayViewMock: ColleaguesListDisplayView {
    var didFetchCalled      = false
    var didFetchViewModel   : ColleaguesList.Fetch.ViewModel?

    var failedToFetchCalled = false
    var failedToFetchError: ColleaguesUseCaseError?

    var didGiveFeedbackCalled = false
    var didGiveFeedbackViewModel: ColleaguesList.GiveFeedback.ViewModel?

    var failedToGiveFeedbackCalled = false
    var failedToGiveFeedackError: ColleaguesUseCaseError?

    func didFetchColleagues(model: ColleaguesList.Fetch.ViewModel) {
        didFetchCalled = true
        didFetchViewModel = model
    }

    func failedToFetchColleagues(error: ColleaguesUseCaseError) {
        failedToFetchCalled = true
        failedToFetchError = error
    }

    func didGiveFeedback(model: ColleaguesList.GiveFeedback.ViewModel) {
        didGiveFeedbackCalled = true
        didGiveFeedbackViewModel = model
    }

    func failedToGiveFeedback(error: ColleaguesUseCaseError) {
        failedToGiveFeedbackCalled = true
        failedToGiveFeedackError = error
    }
}

class ColleaguesListPresenterMock: ColleaguesListPresentationLogic {
    var presentFetchedColleaguesCalled = false
    var colleaguesResponse: ColleaguesList.Fetch.Response?

    var presentGiveFeedbackCalled = false
    var giveFeedbackResponse: ColleaguesList.GiveFeedback.Response?

    required init(displayView: ColleaguesListDisplayView) {}

    func presentFetchedColleagues(_ response: ColleaguesList.Fetch.Response) {
        presentFetchedColleaguesCalled = true
        colleaguesResponse = response
    }

    func presentGiveFeedback(_ response: ColleaguesList.GiveFeedback.Response) {
        presentGiveFeedbackCalled = true
        giveFeedbackResponse = response
    }
}

class ColleaguesListInteractorMock: ColleaguesListBusinessLogic {
    var fetchColleaguesCalled = false
    var fetchColleaguesCalledRequest: ColleaguesList.Fetch.Request?

    var giveColleagueFeedbackCalled = false
    var giveColleagueFeedbackCalledRequest: ColleaguesList.GiveFeedback.Request?

    required init(presenter: ColleaguesListPresentationLogic) {}

    func fetch(_ request: ColleaguesList.Fetch.Request) {
        fetchColleaguesCalled = true
        fetchColleaguesCalledRequest = request
    }

    func giveFeedback(_ request: ColleaguesList.GiveFeedback.Request) {
        giveColleagueFeedbackCalled = true
        giveColleagueFeedbackCalledRequest = request
    }
}
