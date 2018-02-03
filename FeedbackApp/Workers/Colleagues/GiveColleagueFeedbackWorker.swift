//
//  GiveColleagueFeedbackWorker.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import FeedbackAppDomain
import FeedbackAppFileStore

public struct GiveColleagueFeedbackRequest {
    let userId  : User.IdentifierType
}

public final class GiveColleagueFeedbackWorker {
    private let fileStore: FeedbackAppFileStore.ColleaguesUseCase = ColleaguesUseCase()

    typealias ResultType = Result<User, ColleaguesUseCaseError>
    func giveColleagueFeedback(request: GiveColleagueFeedbackRequest,
        completion: (ResultType) -> Void) {
        fileStore.giveColleagueFeedback(id: request.userId)
        { storeResult in
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
