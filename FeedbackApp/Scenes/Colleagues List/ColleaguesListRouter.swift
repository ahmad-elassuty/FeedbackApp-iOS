//
//  ColleaguesListRouter.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import Foundation

final class ColleaguesListRouter: ColleaguesListRoutingLogic {
    weak var viewController: (ColleaguesListDisplayView & BaseViewController)?
    weak var dataStore  : ColleaguesListDataStore?

    init(viewController: BaseViewController & ColleaguesListDisplayView,
         dataStore: ColleaguesListDataStore?) {
        self.viewController     = viewController
        self.dataStore          = dataStore
    }

    func routeToColleagueProfile(colleague: ColleaguesList.Colleague) {
        let optionalUser = dataStore?.users.first(where: { $0.id == colleague.id })
        guard let user = optionalUser else { return }

        // Initialize destination controller
        let destinationController = ColleagueProfileSceneConfigurator.configure()

        // Pass data to destination controller
        destinationController.router.dataStore?.user = user

        // Navigate
        guard let navigationController = viewController?.navigationController else {
            viewController?.present(destinationController, animated: true, completion: nil)
            return
        }

        navigationController.pushViewController(destinationController, animated: true)
    }
}
