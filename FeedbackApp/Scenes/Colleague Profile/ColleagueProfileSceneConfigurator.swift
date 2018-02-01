//
//  ColleagueProfileSceneConfigurator.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

final class ColleagueProfileSceneConfigurator: SceneConfigurator {
    static func configure() -> ColleagueProfileViewController {
        let viewController = ColleagueProfileViewController()
        configure(viewController: viewController)

        return viewController
    }

    static func configure(viewController: ColleagueProfileViewController) {
        let presenter       = ColleagueProfilePresenter(displayView: viewController)
        let interactor      = ColleagueProfileInteractor(presenter: presenter)
        let router          = ColleagueProfileRouter(
            viewController: viewController,
            dataStore: interactor
        )
        viewController.interactor   = interactor
        viewController.router       = router
    }
}
