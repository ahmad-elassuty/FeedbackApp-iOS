//
//  ServerDateFormatter.swift
//  FeedbackAppFileStore
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import Foundation

struct ServerDateFormatter {
    static let shared = ServerDateFormatter()

    private let formatter: DateFormatter!
    private let dateFormat  = Constants.serverDateFormat
    private let timeZone    = Constants.serverTimeZone

    private init() {
        formatter               = DateFormatter()
        formatter.dateFormat    = dateFormat
        formatter.timeZone      = TimeZone(identifier: timeZone)
    }

    func convertStringToDate(string: String) -> Date? {
        return formatter.date(from: string)
    }
}
