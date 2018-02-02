//
//  ColleaguesListPresenter.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import FeedbackAppDomain

final class ColleaguesListPresenter {
    weak var dispalyView: ColleaguesListDisplayView?

    let thresholdDate: TimeInterval
    let updatesQueue: DispatchQueue

    init(displayView: ColleaguesListDisplayView) {
        self.dispalyView = displayView
        thresholdDate  = App.Constants.ColleaguesList.sectionSeparatorThreshold
        updatesQueue = DispatchQueue(
            label: App.Constants.ColleaguesList.viewUpdatesQueueLabel,
            qos: .userInitiated
        )
    }
}

// MARK: - Presentation Logic
extension ColleaguesListPresenter: ColleaguesListPresentationLogic {
    func presentFetchedColleagues(_ response: ColleaguesList.Fetch.Response) {
        guard let users = response.value else {
            dispalyView?.failedToFetchColleagues(error: response.error!)
            return
        }

        /**
         Do grouping and sorting in a background serial queue
          to guarantee transactional updates
        */
        let workItem = DispatchWorkItem { [weak self] in
            let viewModel = self?.buildFetchViewModel(users: users)

            DispatchQueue.main.sync { [weak self] in
                guard let viewModel = viewModel else {
                    return
                }

                self?.dispalyView?.didFetchColleagues(model: viewModel)
            }
        }

        updatesQueue.async(execute: workItem)
    }

    func presentGiveFeedback(_ response: ColleaguesList.GiveFeedback.Response) {
        guard let user = response.value else {
            dispalyView?.failedToGiveFeedback(error: response.error!)
            return
        }

        let colleague   = transformDomainUser(user)
        let viewModel = ColleaguesList.GiveFeedback.ViewModel(colleague: colleague)
        dispalyView?.didGiveFeedback(model: viewModel)
    }
}

// MARK: - Helpers
extension ColleaguesListPresenter {
    func buildFetchViewModel(users: [User]) -> ColleaguesList.Fetch.ViewModel {
        // Classifying colleagues based on interactions
        var groups: [[User]] = [[], [], []]
        let thresholdDate = Date().addingTimeInterval(-self.thresholdDate)

        for user in users {
            guard let recentFeedback = user.recentFeedback else {
                // Didn't interact with before
                groups[0].append(user)
                continue
            }

            let grpIndex = recentFeedback.date < thresholdDate ? 1 : 2
            groups[grpIndex].append(user)
        } // O(n)

        // Sort groups
        groups[1].sort { $0.recentFeedback! < $1.recentFeedback! }
        groups[2].sort { $0.recentFeedback! > $1.recentFeedback! }

        // Form final groups
        let userGroups: [[User]] = [groups[0] + groups[1], groups[2]]
        return transformUserGroups(userGroups: userGroups)
    }
}

// MARK: - Private Methods
private extension ColleaguesListPresenter {
    func transformDomainUser(_ user: User) -> ColleaguesList.Colleague {
        let url = URL(string: user.avatarURLString ?? "")
        let lastFeedbackDate        = user.recentFeedback?.date
        let lastFeedbackDateString  = user.recentFeedback?.date.timeAgoString

        return ColleaguesList.Colleague(
            id: user.id, name: user.name,
            lastFeedbackDate: lastFeedbackDate,
            lastFeedbackDateString: lastFeedbackDateString,
            avatarURL: url
        )
    }

    func transformUserGroups(userGroups: [[User]]) -> ColleaguesList.Fetch.ViewModel {
        func transformUsersToColleagues(_ users: [User]) -> [ColleaguesList.Colleague] {
            return users.map(transformDomainUser)
        }

        let result = userGroups.map(transformUsersToColleagues)
        return ColleaguesList.Fetch.ViewModel(colleagues: result)
    }
}
