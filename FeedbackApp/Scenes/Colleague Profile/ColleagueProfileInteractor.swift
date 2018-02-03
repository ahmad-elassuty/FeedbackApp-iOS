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
        // Respond with the current data
        let response = ColleagueProfile.Fetch.Response(value: user)
        presenter.presentFetchedColleague(response: response)

        // Get updated data
        let workerRequest = FetchColleagueProfileRequest(userId: user.id)
        worker.fetchColleagueProfile(request: workerRequest) { [weak self] result in
            guard result.isSuccess else {
                let response =  ColleagueProfile.Fetch.Response(error: result.error!)
                self?.presenter.presentFetchedColleague(response: response)
                return
            }

            let response =  ColleagueProfile.Fetch.Response(value: result.value!)
            self?.presenter.presentFetchedColleague(response: response)
        }
    }
}
