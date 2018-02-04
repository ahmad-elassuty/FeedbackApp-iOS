//
//  ColleaguesUseCase.swift
//  FeedbackAppDomain
//
//  Created by Ahmed Elassuty on 1/30/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

/**
 ColleaguesUseCase defines all application
    capabilities/use cases regarding colleagues
 */
public protocol ColleaguesUseCase {
    associatedtype FetchColleaguesErrorType      : Error
    associatedtype GiveColleagueFeedbackErrorType: Error
    associatedtype FetchColleagueProfileErrorType: Error

    /**
     Fetch all colleagues

     - parameters:
        - completion: Callback to provide fetched colleagues or Error

     - returns:
        Swift.Void
    */
    func fetchColleagues(
        completion: (Result<[User], FetchColleaguesErrorType>) -> Void
    )

    /**
     Give a specific colleague your feedback

    - parameters:
        - id: Colleague identifier
        - completion: Callback to provide the updated colleague data

     - returns:
        Swift.Void
     */
    func giveColleagueFeedback(
        id: User.IdentifierType,
        completion: (Result<User, GiveColleagueFeedbackErrorType>) -> Void
    )

    /**
     Fetch specific colleague profile data

     - parameters:
        - id: Colleague identifier
        - completion: Callback to provide the fetched colleague profile
            or Error

     - returns:
        Swift.Void
     */
    func fetchColleagueProfile(
        id: User.IdentifierType,
        completion: (Result<User, FetchColleagueProfileErrorType>) -> Void
    )
}
