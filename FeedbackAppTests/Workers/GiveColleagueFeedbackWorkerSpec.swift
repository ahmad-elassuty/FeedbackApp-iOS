//
//  GiveColleagueFeedbackWorkerSpec.swift
//  FeedbackAppTests
//
//  Created by Ahmed Elassuty on 2/3/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import Quick
import Nimble
import FeedbackAppDomain
@testable import FeedbackApp

class GiveColleagueFeedbackWorkerSpec: QuickSpec {
    override func spec() {
        let request = GiveColleagueFeedbackRequest(userId: 1)
        let worker  = GiveColleagueFeedbackWorker()

        describe("Worker") {
            var result: GiveColleagueFeedbackWorker.ResultType?

            afterEach {
                result = nil
            }

            it("should call the completion handler") {
                worker.giveColleagueFeedback(request: request) { workerResult in
                    result = workerResult
                }

                expect(result).toEventuallyNot(beNil())
            }

            it("should return error") {
                worker.giveColleagueFeedback(request: request) { workerResult in
                    result = workerResult
                }

                expect(result?.error).toEventuallyNot(beNil())
            }
        }
    }
}
