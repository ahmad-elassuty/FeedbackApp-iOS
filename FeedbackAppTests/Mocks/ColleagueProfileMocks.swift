//
//  ColleagueProfileMocks.swift
//  FeedbackAppTests
//
//  Created by Ahmed Elassuty on 2/3/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

@testable import FeedbackApp

extension ColleagueProfile.Feedback: Equatable {
    public static func ==(lhs: ColleagueProfile.Feedback, rhs: ColleagueProfile.Feedback) -> Bool {
        return lhs.dateCategory == rhs.dateCategory &&
            lhs.dateString == rhs.dateString
    }
}

extension ColleagueProfile.Colleague: Equatable {
    public static func ==(lhs: ColleagueProfile.Colleague, rhs: ColleagueProfile.Colleague) -> Bool {
        let equalFeedbacksSizes = lhs.feedbacks.count == rhs.feedbacks.count
        let equalFeedbacks = zip(lhs.feedbacks, rhs.feedbacks).reduce(true) { $0 && $1.0 == $1.1 }

        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            equalFeedbacksSizes &&
            equalFeedbacks &&
            lhs.avatarURL == rhs.avatarURL
    }
}

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
