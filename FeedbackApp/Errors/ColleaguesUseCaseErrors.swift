//
//  ColleaguesUseCaseErrors.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import FeedbackAppFileStore

enum ColleaguesUseCaseError: Error {
    case
    fetchColleaguesError(String),
    giveColleagueFeedbackError(String),
    fetchColleagueProfileError(String)
}

extension ColleaguesUseCaseError {
    init(fileStoreError error: FeedbackAppFileStore.FetchColleaguesError) {
        self = .fetchColleagueProfileError("")
    }

    init(fileStoreError error: FeedbackAppFileStore.GiveColleagueFeedbackError) {
        self = .giveColleagueFeedbackError("")
    }

    init(fileStoreError error: FeedbackAppFileStore.FetchColleagueProfileError) {
        self = .fetchColleagueProfileError("")
    }
}
