//
//  ColleagueProfileMocks.swift
//  FeedbackAppTests
//
//  Created by Ahmed Elassuty on 2/3/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import FeedbackAppDomain
@testable import FeedbackApp

class ColleagueProfileDisplayViewMock: ColleagueProfileDisplayView {
    var didFetchCalled      = false
    var didFetchViewModel: ColleagueProfile.Fetch.ViewModel?

    var failedToFetchCalled = false
    var error: ColleaguesUseCaseError?

    func didFetchColleagueProfile(model: ColleagueProfile.Fetch.ViewModel) {
        didFetchCalled = true
        didFetchViewModel = model
    }

    func failedToFetchColleagueProfile(error: ColleaguesUseCaseError) {
        failedToFetchCalled = true
        self.error = error
    }
}

class ColleagueProfilePresenterMock: ColleagueProfilePresentationLogic {
    var presentFetchedColleagueCalled = false
    var response: ColleagueProfile.Fetch.Response?

    required init(displayView: ColleagueProfileDisplayView) {}

    init() {}

    func presentFetchedColleague(response: ColleagueProfile.Fetch.Response) {
        presentFetchedColleagueCalled = true
        self.response = response
    }
}

class ColleagueProfileInteractorMock: ColleagueProfileBusinessLogic {
    var fetchColleagueProfileCalled = false
    var request: ColleagueProfile.Fetch.Request?

    required init(presenter: ColleagueProfilePresentationLogic) {}

    func fetchColleagueProfile(_ request: ColleagueProfile.Fetch.Request) {
        fetchColleagueProfileCalled = true
        self.request = request
    }
}
