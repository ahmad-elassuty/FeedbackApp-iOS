//
//  Errors.swift
//  FeedbackAppFileStore
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

public enum FetchColleaguesError: Error {
    case cannotLoadData
    case cannotParseData
}

public enum GiveColleagueFeedbackError: Error {
    case cannotPersistData
}

public enum FetchColleagueProfileError: Error {
    case userNotFound
}
