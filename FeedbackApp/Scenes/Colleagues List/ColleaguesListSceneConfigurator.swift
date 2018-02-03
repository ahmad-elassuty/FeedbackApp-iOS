//
//  ColleaguesListSceneConfigurator.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import Foundation

struct ColleaguesListSceneConfigurator: SceneConfigurator {
    static func configure() -> ColleaguesListViewController {
        let viewController  = ColleaguesListViewController()
        let presenter       = ColleaguesListPresenter(displayView: viewController)
        let interactor      = ColleaguesListInteractor(presenter: presenter)
        let router          = ColleaguesListRouter(
            viewController: viewController,
            dataStore: interactor
        )
        viewController.interactor   = interactor
        viewController.router       = router

        return viewController
    }
}
