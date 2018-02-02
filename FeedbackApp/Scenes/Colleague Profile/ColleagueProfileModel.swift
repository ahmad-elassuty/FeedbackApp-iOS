//
//  ColleagueProfileModel.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import FeedbackAppDomain

enum ColleagueProfile {}

extension ColleagueProfile {
    struct Feedback {
        let dateCategory    : Theme.DateCategory
        let dateString      : String
    }

    struct Colleague {
        let name     : String
        let avatarURL: URL?
        let feedbacks: [Feedback]
    }
}

extension ColleagueProfile {
    enum Fetch {
        struct Request {}

        typealias Response = Result<User, ColleaguesUseCaseError>

        struct ViewModel {
            let colleague: Colleague
        }
    }
}
