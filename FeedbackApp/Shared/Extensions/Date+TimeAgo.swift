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

        let interval = Calendar.current.dateComponents(
            [.month, .day, .hour, .minute], from: self, to: Date()
        )

        if let month = interval.month, month > 0 {
            return _formatResultString(forValue: month, component: "month")
        }

        if let day = interval.day, day > 0 {
            return _formatResultString(forValue: day, component: "day")
        }

        if let hour = interval.hour, hour > 0 {
            return _formatResultString(forValue: hour, component: "hour")
        }

        if let minute = interval.minute, minute > 0 {
            return _formatResultString(forValue: minute, component: "minute")
        }

        return "just now"
    }
}
