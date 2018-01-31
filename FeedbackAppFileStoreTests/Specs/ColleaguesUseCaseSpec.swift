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

class ColleaguesUseCaseSpec: QuickSpec {
    override func spec() {
        describe("ColleaguesUseCase") {
            context("fetch colleagues from file with data") {
                it("should return list of users") {
                    let store = ColleaguesUseCase()
                    store.fetchColleagues { result in
                        expect(result.value).toNot(beNil())
                    }
                }
            }

            context("fetch colleagues from not existing file") {
                it("should fail to load data") {
                    let store = ColleaguesUseCase(dataFileName: "")
                    store.fetchColleagues { result in
                        expect(result.error).to(equal(.cannotLoadData))
                    }
                }
            }
        }
    }
}
