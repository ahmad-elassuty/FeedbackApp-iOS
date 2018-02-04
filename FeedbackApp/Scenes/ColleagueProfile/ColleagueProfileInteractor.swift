//
//  ColleagueProfileInteractor.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import FeedbackAppDomain

final class ColleagueProfileInteractor: ColleagueProfileDataStore {
    var user     : User!
    var presenter: ColleagueProfilePresentationLogic

    let worker = FetchColleagueProfileWorker()

    init(presenter: ColleagueProfilePresentationLogic) {
        self.presenter = presenter
    }
}

extension ColleagueProfileInteractor: ColleagueProfileBusinessLogic {
    func fetchColleagueProfile(_ request: ColleagueProfile.Fetch.Request) {
        // Show old data
        let response =  ColleagueProfile.Fetch.Response(value: user)
        presenter.presentFetchedColleague(response: response)

        // Fetch updated data
        /**
         Important:

         Since file store does not persist giving feedback, changes to user
         feedbacks will not reflect in the colleague profile fetched.
         */

//        let workerRequest = FetchColleagueProfileRequest(userId: user.id)
//        worker.fetchColleagueProfile(request: workerRequest) { [weak self] result in
//            guard let `self` = self else { return }
//
//            guard result.isSuccess else {
//                let response =  ColleagueProfile.Fetch.Response(error: result.error!)
//                self.presenter.presentFetchedColleague(response: response)
//                return
//            }
//
//            let response =  ColleagueProfile.Fetch.Response(value: result.value!)
//            self.presenter.presentFetchedColleague(response: response)
//        }
    }
}
