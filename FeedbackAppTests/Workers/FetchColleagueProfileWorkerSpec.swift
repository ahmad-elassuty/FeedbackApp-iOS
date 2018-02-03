//
//  FetchColleagueProfileWorkerSpec.swift
//  FeedbackAppTests
//
//  Created by Ahmed Elassuty on 2/3/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import Quick
import Nimble
import FeedbackAppDomain
@testable import FeedbackApp

class FetchColleagueProfileWorkerSpec: QuickSpec {
    override func spec() {
        let request = FetchColleagueProfileRequest(userId: 1)
        let worker  = FetchColleagueProfileWorker()

        describe("Worker") {
            var result: FetchColleagueProfileWorker.ResultType?

            afterEach {
                result = nil
            }

            it("should call the completion handler") {
                worker.fetchColleagueProfile(request: request) { workerResult in
                    result = workerResult
                }

                expect(result).toEventuallyNot(beNil())
            }

            it("should return a valid user") {
                worker.fetchColleagueProfile(request: request) { workerResult in
                    result = workerResult
                }

                expect(result?.value).toEventuallyNot(beNil())
            }
        }
    }
}
