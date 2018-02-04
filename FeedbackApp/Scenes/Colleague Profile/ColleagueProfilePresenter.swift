//
//  ColleagueProfilePresenter.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import FeedbackAppDomain

final class ColleagueProfilePresenter: ColleagueProfilePresentationLogic {
    weak var displayView: ColleagueProfileDisplayView?

    init(displayView: ColleagueProfileDisplayView) {
        self.displayView = displayView
    }
}

extension ColleagueProfilePresenter {
    func presentFetchedColleague(response: ColleagueProfile.Fetch.Response) {
        guard response.isSuccess else {
            displayView?.failedToFetchColleagueProfile(error: response.error!)
            return
        }

        let viewModel = transformDomainUser(response.value!)
        displayView?.didFetchColleagueProfile(model: viewModel)
    }
}

private extension ColleagueProfilePresenter {
    typealias ViewModel = ColleagueProfile.Fetch.ViewModel
    
    func transformDomainUser(_ user: User) -> ViewModel {
        let avatarURL = URL(string: user.avatarURLString ?? "")
        let colleague = ColleagueProfile.Colleague(
            id: user.id,
            name: user.name.capitalized,
            avatarURL: avatarURL,
            feedbacks: user.feedbacks.map(transformDomainFeedback)
        )

        return ViewModel(colleague: colleague)
    }

    func transformDomainFeedback(_ feedback: Feedback) -> ColleagueProfile.Feedback {
        let category    = Theme.DateCategory(date: feedback.date)!
        let dateString  = feedback.date.timeAgoString

        return ColleagueProfile.Feedback(
            dateCategory: category,
            dateString: dateString
        )
    }
}
