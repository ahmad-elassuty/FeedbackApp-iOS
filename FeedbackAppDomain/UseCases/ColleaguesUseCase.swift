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
protocol ColleaguesUseCase {
    associatedtype FetchColleaguesError         : Error
    associatedtype GiveColleagueFeedbackError   : Error
    associatedtype FetchColleagueProfileError   : Error

    /**
     Fetch all colleagues

     - parameters:
        - completion: Callback to provide fetched colleagues or Error

     - returns:
        Swift.Void
    */
    func fetchColleagues(
        completion: (Result<[User], FetchColleaguesError>) -> Void
    )


    /**
     Give a specific colleague your feedback

    - parameters:
        - id: Colleague identifier
        - feedback: New feedback data object
        - completion: Callback to provide the updated colleague data

     - returns:
        Swift.Void
     */
    func giveColleagueFeedback(
        id: User.IdentifierType,
        feedback: Feedback,
        completion: (Result<User, GiveColleagueFeedbackError>) -> Void
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
        completion: (Result<User, GiveColleagueFeedbackError>) -> Void
    )
}
