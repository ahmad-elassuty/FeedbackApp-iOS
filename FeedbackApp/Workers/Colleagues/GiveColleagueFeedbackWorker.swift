//
//  GiveColleagueFeedbackWorker.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import FeedbackAppDomain
import FeedbackAppFileStore

protocol GiveColleagueFeedbackRequest {
    var userId: User.IdentifierType { get }
    var feedback: Feedback          { get }
}

final class GiveColleagueFeedbackWorker {
    let fileStore: FeedbackAppFileStore.ColleaguesUseCase = ColleaguesUseCase()

    typealias ResultType = Result<User, ColleaguesUseCaseError>
    func giveColleagueFeedback(request: GiveColleagueFeedbackRequest, feedback: Feedback,
        completion: (ResultType) -> Void) {
        fileStore.giveColleagueFeedback(id: request.userId, feedback: feedback) { storeResult in
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
