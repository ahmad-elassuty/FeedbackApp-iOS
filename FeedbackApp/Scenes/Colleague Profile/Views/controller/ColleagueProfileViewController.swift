//
//  ColleagueProfileViewController.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import UIKit

class ColleagueProfileViewController: BaseViewController {
    @IBOutlet weak var colleagueProfileTableView: UITableView!
    weak var colleagueProfileHeaderView: ColleagueProfileTableHeader!

    var interactor  : ColleagueProfileBusinessLogic!
    var router      : ColleagueProfileRoutingLogic!
    var colleague   : ColleagueProfile.Colleague!

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        fetchColleague()
    }
}

// MARK: - Colleague Profile Display View
extension ColleagueProfileViewController: ColleagueProfileDisplayView {
    func didFetchColleagueProfile(model: ColleagueProfile.Fetch.ViewModel) {
        colleague = model.colleague
        reloadData()
    }

    func failedToFetchColleagueProfile(error: ColleaguesUseCaseError) {
        switch error {
        case .fetchColleagueProfileError: break
        default: break
        }
    }
}

// MARK: - Table View Data Source
extension ColleagueProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colleague?.feedbacks.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let colleague = colleague else {
            return nil
        }

        return "Feedback given to \(colleague.name.capitalized)"
    }
}

// MARK: - Private Methods
private extension ColleagueProfileViewController {
    func fetchColleague() {
    }

    func prepareView() {
        prepareNavigationItems()
        prepareTableView()
    }

    func prepareNavigationItems() {
        title = "Profile"

        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
    }

    func prepareTableView() {
        colleagueProfileTableView.estimatedRowHeight = 100
        colleagueProfileTableView.rowHeight = UITableViewAutomaticDimension

        colleagueProfileHeaderView = ColleagueProfileTableHeader()
        colleagueProfileTableView.tableHeaderView = colleagueProfileHeaderView

        colleagueProfileTableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")
    }

    func reloadData() {
        let name = colleague.name
        let avatarURL = colleague.avatarURL

        colleagueProfileHeaderView.setColleague(name: name, imageURL: avatarURL)
        colleagueProfileTableView.reloadData()
    }
}
