//
//  Date+JSONTransformer.swift
//  FeedbackAppFileStore
//
//  Created by Ahmed Elassuty on 1/30/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import Foundation
import Marshal

extension Date : ValueType {
    public static func value(from object: Any) throws -> Date {
        guard let dateString = object as? String else {
            throw MarshalError.typeMismatch(expected: String.self, actual: type(of: object))
        }

        let optionalDate = ServerDateFormatter.shared.convertStringToDate(string: dateString)
        guard let date = optionalDate else {
            throw MarshalError.typeMismatch(
                expected: "Date string formated as \(Constants.serverDateFormat)",
                actual: dateString
            )
        }

        return date
    }
}
