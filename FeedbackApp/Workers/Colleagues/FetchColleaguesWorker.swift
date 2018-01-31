//
//  FetchColleaguesWorker.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import FeedbackAppDomain
import FeedbackAppFileStore

protocol FetchColleaguesRequest {}

final class FetchColleaguesWorker {
    let fileStore: FeedbackAppFileStore.ColleaguesUseCase = ColleaguesUseCase()

    typealias ResultType = Result<[User], ColleaguesUseCaseError>
    func fetchColleagues(request: FetchColleaguesRequest, completion: (ResultType) -> Void) {
        fileStore.fetchColleagues { storeResult in
            guard storeResult.isSuccess else {
                let error = ColleaguesUseCaseError(fileStoreError: storeResult.error!)
                let result = ResultType(error: error)
                completion(result)
                return
            }

            let result = ResultType(value: storeResult.value!)
            completion(result)
        }
    }
}
