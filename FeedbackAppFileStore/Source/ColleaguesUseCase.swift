//
//  ColleaguesUseCase.swift
//  FeedbackAppFileStore
//
//  Created by Ahmed Elassuty on 1/30/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import FeedbackAppDomain
import Marshal

public class ColleaguesUseCase: FeedbackAppDomain.ColleaguesUseCase {
    let dataFileName: String
    let bundle: Bundle?

    public init(dataFileName: String? = nil, bundle: Bundle? = nil) {
        self.dataFileName   = dataFileName ?? Constants.dataFileName
        self.bundle         = bundle
    }

    public func fetchColleagues(completion: (Result<[User], FetchColleaguesError>) -> Void) {
        let result = prepareFetchColleaguesResult()
        completion(result)
    }

    public func giveColleagueFeedback(id: Int,
        completion: (Result<User, GiveColleagueFeedbackError>) -> Void) {
        let result: Result<User, GiveColleagueFeedbackError> = Result(error: .cannotPersistData)
        completion(result)
    }

    public func fetchColleagueProfile(
        id: User.IdentifierType,
        completion: (Result<User, FetchColleagueProfileError>) -> Void) {

        fetchColleagues { result in
            guard let users = result.value else {
                return
            }

            let optionalUser = users.first { $0.id == id }
            guard let user = optionalUser else {
                let response: Result<User, FetchColleagueProfileError> = Result(error: .userNotFound)
                completion(response)
                return
            }

            let response: Result<User, FetchColleagueProfileError> = Result(value: user)
            completion(response)
        }
    }
}

private extension ColleaguesUseCase {
    func prepareFetchColleaguesResult() -> Result<[User], FetchColleaguesError> {
        do {
            let JSON = try JSONFileReader.loadResource(dataFileName, bundle: bundle)
            let colleagues: [FSUser] = try JSON.value(for: "users")
            let value = colleagues.map({ $0.asDomainUser() })

            return Result(value: value)
        } catch is MarshalError {
            return Result(error: .cannotParseData)
        } catch JSONFileReaderError.cannotBeParsedToJSON {
            return Result(error: .cannotParseData)
        } catch {
            return Result(error: .cannotLoadData)
        }
    }
}
