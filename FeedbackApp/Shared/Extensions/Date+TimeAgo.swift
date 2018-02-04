//
//  Date+TimeAgo.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import Foundation

extension Date {
    var timeAgoString: String {
        func _formatResultString(forValue value: Int,
                                 component: String) -> String {
            var component = component

            if value > 1 {
                component += "s"
            }

            return "\(value) \(component) ago"
        }

        let components = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute], from: self, to: Date()
        )

        if let year = components.year, year > 0 {
            return _formatResultString(forValue: year, component: "year")
        }

        if let month = components.month, month > 0 {
            return _formatResultString(forValue: month, component: "month")
        }

        if let day = components.day, day > 0 {
            return _formatResultString(forValue: day, component: "day")
        }

        if let hour = components.hour, hour > 0 {
            return _formatResultString(forValue: hour, component: "hour")
        }

        if let minute = components.minute, minute > 0 {
            return _formatResultString(forValue: minute, component: "minute")
        }

        return "just now"
    }
}
