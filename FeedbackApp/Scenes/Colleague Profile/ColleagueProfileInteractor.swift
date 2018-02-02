//
//  ColleagueProfileInteractor.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import FeedbackAppDomain

final class ColleagueProfileInteractor: ColleagueProfileDataStore {
    var user        : User!
    var presenter   : ColleagueProfilePresentationLogic

    let worker = FetchColleagueProfileWorker()

    init(presenter: ColleagueProfilePresentationLogic) {
        self.presenter = presenter
    }
}

extension ColleagueProfileInteractor: ColleagueProfileBusinessLogic {

    /**
     This method simulates fetching specific user

     The real implementation of this function should call the concerned worker to
     do the real business logic.
     */
    func fetchColleagueProfile(_ request: ColleagueProfile.Fetch.Request) {
        let response = ColleagueProfile.Fetch.Response(value: user)
        presenter.presentFetchedColleague(response: response)
    }
}
