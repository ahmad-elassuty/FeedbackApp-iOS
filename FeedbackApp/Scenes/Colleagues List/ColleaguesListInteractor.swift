//
//  ColleaguesListInteractor.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import FeedbackAppDomain

final class ColleaguesListInteractor: ColleaguesListBusinessLogic, ColleaguesListDataStore {
    var presenter   : ColleaguesListPresentationLogic
    var users       : [User]

    let fetchColleaguesWorker   = FetchColleaguesWorker()
    let giveFeedbackWorker      = GiveColleagueFeedbackWorker()

    init(presenter: ColleaguesListPresentationLogic) {
        self.presenter  = presenter
        self.users = []
    }
}

// MARK: - Fetch
extension ColleaguesListInteractor {
    func fetch(_ request: ColleaguesList.Fetch.Request) {
        fetchColleaguesWorker.fetchColleagues(request: request) { result in
            guard result.isSuccess else {
                let response = ColleaguesList.Fetch.Response(error: result.error!)
                presenter.presentFetchedColleagues(response)
                return
            }

            users = result.value!
            let response = ColleaguesList.Fetch.Response(value: users)
            presenter.presentFetchedColleagues(response)
        }
    }
}

// MARK: - Give feedback
extension ColleaguesListInteractor {
    /**
     This method simulates giving specific user a feedback

     The real implementation of this function should call the concerned worker to
     do the real business logic.
     */
    func giveFeedback(_ request: ColleaguesList.GiveFeedback.Request) {
        let id = request.userId
        let userIndex = users.index { $0.id == id }

        guard let index = userIndex else {
            let error = ColleaguesUseCaseError.giveColleagueFeedbackError("Colleague not found.")
            let response = ColleaguesList.GiveFeedback.Response(error: error)
            presenter.presentGiveFeedback(response)
            return
        }

        let feedback = Feedback(id: 1, date: Date.currentLocalizedDate)
        users[index].giveFeedback(feedback)

        let response = ColleaguesList.GiveFeedback.Response(value: users[index])
        presenter.presentGiveFeedback(response)
    }
}
