//
//  ThemeDateCategorySpec.swift
//  FeedbackAppTests
//
//  Created by Ahmed Elassuty on 2/3/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import Quick
import Nimble
@testable import FeedbackApp

class ThemeDateCategorySpec: QuickSpec {
    override func spec() {
        describe("DateCategory") {
            var date: Date!

            beforeEach {
                date = Date()
            }

            it("should be less than month") {
                let category = Theme.DateCategory(date: date)

                expect(category).to(equal(.lessThanMonth))
            }

            it("should be less than year") {
                date.addTimeInterval(2 * monthInterval)
                let category = Theme.DateCategory(date: date)

                expect(category).to(equal(.lessThanYear))
            }

            it("should be more than year") {
                date.addTimeInterval(2 * yearInterval)
                let category = Theme.DateCategory(date: date)

                expect(category).to(equal(.moreThanYear))
            }
        }
    }
}
