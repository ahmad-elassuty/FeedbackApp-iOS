//
//  ColleagueProfileViewController.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import UIKit

class ColleagueProfileViewController: BaseViewController {
    var interactor  : ColleagueProfileBusinessLogic!
    var router      : ColleagueProfileRoutingLogic!

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
    }
}

extension ColleagueProfileViewController: ColleagueProfileDisplayView {
    func didFetchColleagueProfile(model: ColleagueProfile.Fetch.ViewModel) {

    }

    func failedToFetchColleagueProfile(error: ColleaguesUseCaseError) {
        
    }
}
