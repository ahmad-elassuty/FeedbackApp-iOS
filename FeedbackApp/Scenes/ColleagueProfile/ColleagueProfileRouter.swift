//
//  ColleagueProfileRouter.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import Foundation

final class ColleagueProfileRouter: ColleagueProfileRoutingLogic {
    weak var viewController: (BaseViewController & ColleagueProfileDisplayView)?
    weak var dataStore: ColleagueProfileDataStore?

    init(viewController: BaseViewController & ColleagueProfileDisplayView,
         dataStore: ColleagueProfileDataStore?) {
        self.viewController = viewController
        self.dataStore      = dataStore
    }
}
