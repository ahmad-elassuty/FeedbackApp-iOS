//
//  ColleagueProfilePresenter.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

final class ColleagueProfilePresenter: ColleagueProfilePresentationLogic {
    weak var displayView: ColleagueProfileDisplayView?

    init(displayView: ColleagueProfileDisplayView) {
        self.displayView = displayView
    }
}
