//
//  ResultSpec.swift
//  FeedbackAppDomainTests
//
//  Created by Ahmed Elassuty on 1/30/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import Quick
import Nimble
import FeedbackAppDomain

extension String: Error {}

class ResultSpec: QuickSpec {
    override func spec() {
        describe("Result Object") {
            var successfulResult: Result<Int, String>!
            var failedResult    : Result<Int, String>!

            let value       = 1
            let errorMsg    = "error"
            
            beforeEach {
                successfulResult = Result(value: value)
                failedResult    = Result(error: errorMsg)
            }

            context("when initialized") {
                it("should have value") {
                    expect(successfulResult.value).to(equal(value))
                }

                it("should have error") {
                    expect(failedResult.error).to(equal(errorMsg))
                }
            }

            context("when status checked") {
                it("should return the based on the stored values") {
                    expect(successfulResult.isSuccess).to(beTrue())
                    expect(successfulResult.isError).to(beFalse())
                    expect(failedResult.isError).to(beTrue())
                    expect(failedResult.isSuccess).to(beFalse())
                }
            }
        }
    }
}
