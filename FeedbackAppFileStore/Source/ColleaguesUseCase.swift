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

    public init(dataFileName: String? = nil) {
        self.dataFileName = dataFileName ?? Constants.dataFileName
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
        let result: Result<User, FetchColleagueProfileError> = Result(error: .cannotPerformQueries)
        completion(result)
    }
}

private extension ColleaguesUseCase {
    func prepareFetchColleaguesResult() -> Result<[User], FetchColleaguesError> {
        do {
            let JSON = try JSONFileReader.loadResource(dataFileName)
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
