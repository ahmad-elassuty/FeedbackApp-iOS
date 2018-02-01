//
//  ColleaguesListProtocols.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import FeedbackAppDomain

// View
protocol ColleaguesListDisplayView: class {
    func didFetchColleagues(model: ColleaguesList.Fetch.ViewModel)
    func failedToFetchColleagues(error: ColleaguesUseCaseError)

    func didGiveFeedback(model: ColleaguesList.GiveFeedback.ViewModel)
    func failedToGiveFeedback(error: ColleaguesUseCaseError)
}

// Interactor
protocol ColleaguesListBusinessLogic: class {
    init(presenter: ColleaguesListPresentationLogic)

    func fetch(_ request: FetchColleaguesRequest)
    func giveFeedback(_ request: GiveColleagueFeedbackRequest)
}

// Presenter
protocol ColleaguesListPresentationLogic {
    init(displayView: ColleaguesListDisplayView)

    func presentFetchedColleagues(_ response: ColleaguesList.Fetch.Response)
    func presentGiveFeedback(_ response: ColleaguesList.GiveFeedback.Response)
}

// Router
protocol ColleaguesListRoutingLogic {
    init(viewController: ColleaguesListDisplayView & BaseViewController,
         dataStore: ColleaguesListDataStore?)

    func routeToColleagueProfile(colleague: ColleaguesList.Colleague)
}

// Data Store
protocol ColleaguesListDataStore: class {
    var users: [User] { get }
}
