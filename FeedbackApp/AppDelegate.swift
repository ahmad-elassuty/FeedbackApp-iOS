//
//  AppDelegate.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/30/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let screenBounds = UIScreen.main.bounds
        window = UIWindow(frame: screenBounds)
        window?.rootViewController = getRootViewController()
        window?.makeKeyAndVisible()

        return true
    }
}

private extension AppDelegate {
    func getRootViewController() -> UIViewController {
        let colleaguesListViewController = ColleaguesListSceneConfigurator.configure()
        let navigationController = UINavigationController(
            rootViewController: colleaguesListViewController
        )

        if #available(iOS 11.0, *) {
            navigationController.navigationBar.prefersLargeTitles = true
        }

        Theme.configure(navigationController)

        return navigationController
    }
}
