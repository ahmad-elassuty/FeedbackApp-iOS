//
//  ColleagueProfileProtocols.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import FeedbackAppDomain

// View
protocol ColleagueProfileDisplayView: class {    
    func didFetchColleagueProfile(model: ColleagueProfile.Fetch.ViewModel)
    func failedToFetchColleagueProfile(error: ColleaguesUseCaseError)
}

// Presenter
protocol ColleagueProfilePresentationLogic {
    init(displayView: ColleagueProfileDisplayView)
}

// Interactor
protocol ColleagueProfileBusinessLogic: class {
    init(presenter: ColleagueProfilePresentationLogic)

    func fetchColleagueProfile(_ request: FetchColleagueProfileRequest)
}

// Routing
protocol ColleagueProfileRoutingLogic {
    weak var dataStore: ColleagueProfileDataStore? { get }

    init(viewController: ColleagueProfileDisplayView & BaseViewController,
         dataStore: ColleagueProfileDataStore?)
}

// Data Store
protocol ColleagueProfileDataStore: class {
    var user: User! { get set }
}
