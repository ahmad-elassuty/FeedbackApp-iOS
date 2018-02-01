//
//  ColleagueProfileModel.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import Foundation

enum ColleagueProfile {}

extension ColleagueProfile {
    enum Fetch {
        struct ViewModel {
            let name            : String
            let avatarURL       : URL?
            let feedbackDates   : [String]
        }
    }
}
