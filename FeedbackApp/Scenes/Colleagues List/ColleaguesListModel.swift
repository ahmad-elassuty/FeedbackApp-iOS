//
//  ColleaguesListModel.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import FeedbackAppDomain

struct ColleaguesList {
    struct Colleague: Identifiable, Equatable {
        let id                      : Int
        let name                    : String
        let lastFeedbackDate        : Date?
        let lastFeedbackDateString  : String?
        let avatarURL               : URL?
    }
}

extension ColleaguesList {
    enum GiveFeedback {
        typealias Response = Result<User, ColleaguesUseCaseError>

        struct ViewModel {
            let colleague: Colleague
        }
    }
}

extension ColleaguesList {
    enum Fetch {
        typealias Response = Result<[User], ColleaguesUseCaseError>

        struct ViewModel {
            let colleagues: [[Colleague]]
        }
    }
}
