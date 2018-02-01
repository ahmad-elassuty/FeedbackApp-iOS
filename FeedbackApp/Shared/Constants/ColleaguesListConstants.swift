//
//  ColleaguesListConstants.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import Foundation

extension App.Constants {
    enum ColleaguesList {
        static let sectionSeparatorThreshold: TimeInterval = 1 * 7 * 24 * 60 * 60 // 2 weeks
        static let viewUpdatesQueueLabel = "colleaguesList.viewUpdates"
    }
}
