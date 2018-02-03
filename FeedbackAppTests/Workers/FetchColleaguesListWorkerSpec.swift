//
//  FetchColleaguesListWorkerSpec.swift
//  FeedbackAppTests
//
//  Created by Ahmed Elassuty on 2/3/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import Quick
import Nimble
import FeedbackAppDomain
@testable import FeedbackApp

class FetchColleaguesListWorkerSpec: QuickSpec {
    override func spec() {
        let request = FetchColleaguesRequest()
        let worker  = FetchColleaguesWorker()

        describe("Worker") {
            var result: FetchColleaguesWorker.ResultType?

            afterEach {
                result = nil
            }

            it("should call the completion handler") {
                worker.fetchColleagues(request: request) { workerResult in
                    result = workerResult
                }

                expect(result).toEventuallyNot(beNil())
            }

            it("should return list of users") {
                worker.fetchColleagues(request: request) { workerResult in
                    result = workerResult
                }

                expect(result?.value).toEventuallyNot(beNil())
                expect(result?.value?.isEmpty).toEventually(beFalse())
            }
        }
    }
}
