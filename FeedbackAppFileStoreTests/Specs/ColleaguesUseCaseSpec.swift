//
//  ColleaguesUseCaseSpec.swift
//  FeedbackAppFileStoreTests
//
//  Created by Ahmed Elassuty on 1/30/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import Quick
import Nimble
import FeedbackAppFileStore
import FeedbackAppDomain

class ColleaguesUseCaseSpec: QuickSpec {
    let user = User(
        id: 1, name: "John Doe",
        email: "john@feedback.com",
        avatarURLString: "https://s3.amazonaws.com/uifaces/faces/twitter/sauro/128.jpg",
        feedbacks: []
    )

    override func spec() {
        let bundle  = Bundle(for: type(of: self))

        describe("ColleaguesUseCase") {

            // MARK: - Fetch Colleagues
            describe("Fetch colleagues") {
                var result  : Result<[User], FetchColleaguesError>?

                beforeEach {
                    result = nil
                }

                context("fetch colleagues from file with data") {
                    it("should return list of users") {
                        let store = ColleaguesUseCase(
                            dataFileName: "test_data",
                            bundle: bundle
                        )

                        store.fetchColleagues { storeResult in
                            result = storeResult
                        }

                        expect(result?.value).toEventually(equal([self.user]))
                    }
                }

                context("fetch colleagues from not existing file") {
                    it("should fail to load data") {
                        let store = ColleaguesUseCase(dataFileName: "")
                        store.fetchColleagues { storeResult in
                            result = storeResult
                        }

                        expect(result?.error).toEventually(equal(.cannotLoadData))
                    }
                }

                context("fetch colleagues from unstructured file") {
                    it("should fail to parse unstructured user") {
                        let store = ColleaguesUseCase(
                            dataFileName: "unformatted_data",
                            bundle: bundle
                        )

                        store.fetchColleagues { storeResult in
                            result = storeResult
                        }

                        expect(result?.error).toEventually(equal(.cannotParseData))
                    }

                    it("should fail to parse different file structure") {
                        let store = ColleaguesUseCase(
                            dataFileName: "unstructured_data",
                            bundle: bundle
                        )

                        store.fetchColleagues { storeResult in
                            result = storeResult
                        }

                        expect(result?.error).toEventually(equal(.cannotParseData))
                    }
                }
            }

            // MARK: - Fetch Colleague Profile
            describe("Fetch Colleague Profile") {
                var result  : Result<User, FetchColleagueProfileError>?
                var store   : FeedbackAppFileStore.ColleaguesUseCase!

                beforeEach {
                    result  = nil
                    store   = ColleaguesUseCase(dataFileName: "test_data", bundle: bundle)
                }

                context("not valid id") {
                    it("should return user not found") {
                        let invalidId = -1
                        store.fetchColleagueProfile(id: invalidId) { storeResult in
                            result = storeResult
                        }

                        expect(result?.error).toEventually(equal(.userNotFound))
                    }
                }

                context("valid user id") {
                    it("should return user") {
                        store.fetchColleagueProfile(id: self.user.id) { storeResult in
                            result = storeResult
                        }

                        expect(result?.value?.id).toEventually(equal(self.user.id))
                    }
                }
            }
        }
    }
}
