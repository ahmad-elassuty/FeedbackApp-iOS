//
//  ColleagueProfileInteractor.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import FeedbackAppDomain

final class ColleagueProfileInteractor: ColleagueProfileDataStore {
    var user        : User?
    var presenter   : ColleagueProfilePresentationLogic

    init(presenter: ColleagueProfilePresentationLogic) {
        self.presenter = presenter
    }
}

extension ColleagueProfileInteractor: ColleagueProfileBusinessLogic {
    func fetchColleagueProfile(_ request: FetchColleagueProfileRequest) {

    }
}
