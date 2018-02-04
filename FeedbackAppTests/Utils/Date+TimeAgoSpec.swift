//
//  Date+TimeAgoSpec.swift
//  FeedbackAppTests
//
//  Created by Ahmed Elassuty on 2/3/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import Quick
import Nimble
@testable import FeedbackApp

class DateTimeAgoSpec: QuickSpec {
    override func spec() {
        describe("TimeAgoExtension") {
            var date: Date!

            beforeEach {
                date = Date()
            }

            context("minutes") {
                it("should return minutes ago") {
                    date.addTimeInterval(minuteInterval)
                    expect(date.timeAgoString).to(equal("1 minute ago"))

                    date.addTimeInterval(minuteInterval)
                    expect(date.timeAgoString).to(equal("2 minutes ago"))
                }
            }

            context("hours") {
                it("should return hours ago") {
                    date.addTimeInterval(hourInterval)
                    expect(date.timeAgoString).to(equal("1 hour ago"))

                    date.addTimeInterval(hourInterval)
                    expect(date.timeAgoString).to(equal("2 hours ago"))
                }
            }

            context("days") {
                it("should return days ago") {
                    date.addTimeInterval(dayInterval)
                    expect(date.timeAgoString).to(equal("1 day ago"))

                    date.addTimeInterval(dayInterval)
                    expect(date.timeAgoString).to(equal("2 days ago"))
                }
            }

            context("months") {
                it("should return month ago") {
                    date.addTimeInterval(monthInterval)
                    expect(date.timeAgoString).to(equal("1 month ago"))

                    date.addTimeInterval(monthInterval)
                    expect(date.timeAgoString).to(equal("2 months ago"))

                }
            }

            context("years") {
                it("should return hour ago") {
                    date.addTimeInterval(yearInterval)
                    expect(date.timeAgoString).to(equal("1 year ago"))

                    date.addTimeInterval(yearInterval)
                    expect(date.timeAgoString).to(equal("2 years ago"))
                }
            }
        }
    }
}
