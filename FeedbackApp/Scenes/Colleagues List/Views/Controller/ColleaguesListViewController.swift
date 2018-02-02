//
//  ColleaguesListViewController.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import UIKit

// MARK: - View Controller
class ColleaguesListViewController: BaseViewController {
    @IBOutlet weak var colleaguesTableView: UITableView!

    var colleagues: [[ColleaguesList.Colleague]] = [[], []]
    var interactor: ColleaguesListBusinessLogic!
    var router    : ColleaguesListRoutingLogic!

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        fetchColleagues()
    }
}

// MARK: - Private Methods Extension
private extension ColleaguesListViewController {
    func prepareView() {
        prepareNavigationBarItems()
        prepareColleaguesTableView()
    }

    @objc func fetchColleagues() {
        let request = ColleaguesList.Fetch.Request()
        interactor.fetch(request)
    }

    func prepareNavigationBarItems() {
        title = "Colleagues"

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Reset", style: .plain,
            target: self, action: #selector(resetData)
        )
    }

    func prepareColleaguesTableView() {
        colleaguesTableView.estimatedRowHeight  = 100
        colleaguesTableView.rowHeight           = UITableViewAutomaticDimension

        colleaguesTableView.register(ColleaguesListTableViewCell.self)
    }

    @objc func resetData() {
        let request = FetchColleaguesRequest()
        interactor.fetch(request)
    }
}

// MARK: - Table view delegate extension
extension ColleaguesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let colleague = colleagues[indexPath]
        router.routeToColleagueProfile(colleague: colleague)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = Section(rawValue: section)!
        return colleagues.titleForSection(section)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = Section(rawValue: section)!
        return colleagues.isEmptySection(section) ? 0 : 30
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = Section(rawValue: section)!
        return colleagues.isEmptySection(section) ? 0 : 20
    }
}

// MARK: - Table view data source extension
extension ColleaguesListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return colleagues.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = Section(rawValue: section)!
        return colleagues.numberOfColleagues(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let colleague = colleagues[indexPath]
        let cell: ColleaguesListTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)

        // Setup cell data
        cell.prepareForUse(colleague: colleague)

        // Setup actions
        cell.giveColleagueFeedbackTapped = { [weak self] colleagueId in
            let request = GiveColleagueFeedbackRequest(userId: colleagueId)
            self?.interactor.giveFeedback(request)
        }

        return cell
    }
}

// MARK: - Colleagues List Display View
extension ColleaguesListViewController: ColleaguesListDisplayView {
    func didFetchColleagues(model: ColleaguesList.Fetch.ViewModel) {
        // Store new data
        colleagues = model.colleagues

        let numberOfSections = colleagues.numberOfSections
        colleaguesTableView.beginUpdates()
        colleaguesTableView.reloadSections(IndexSet(0..<numberOfSections), with: .fade)
        colleaguesTableView.endUpdates()
    }

    func failedToFetchColleagues(error: ColleaguesUseCaseError) {
        switch error {
        case .fetchColleaguesError: break
        default: break
        }
    }

    func didGiveFeedback(model: ColleaguesList.GiveFeedback.ViewModel) {
        let colleague = model.colleague

        // Get old indexPath of the updated colleague
        let colleagueIndexPath = colleagues.indexPathOfColleague(colleague)
        guard let oldIndexPath = colleagueIndexPath else {
            return
        }

        // Update data
        let sectionIndex = Section.recentlyInteractedWith.rawValue
        let indexPath = IndexPath(row: 0, section: sectionIndex)
        colleagues.removeColleagueAtIndexPath(oldIndexPath)
        colleagues[indexPath] = colleague

        // Animate changes
        colleaguesTableView.beginUpdates()
        colleaguesTableView.deleteRows(at: [oldIndexPath], with: .fade)
        colleaguesTableView.insertRows(at: [indexPath], with: .fade)
        colleaguesTableView.endUpdates()
    }

    func failedToGiveFeedback(error: ColleaguesUseCaseError) {
        switch error {
        case .giveColleagueFeedbackError: break
        default: break
        }
    }
}

// MARK: Data Source Extension
fileprivate enum Section: Int {
    case giveFeedback,
    recentlyInteractedWith

    var title: String {
        switch self {
        case .giveFeedback:
            return "Give them some feedback"
        case .recentlyInteractedWith:
            return "You gave them feedback recently"
        }
    }

    var totalNumberOfSections: Int {
        return 2
    }
}

fileprivate extension Array where Element == [ColleaguesList.Colleague] {
    typealias Colleague = ColleaguesList.Colleague
    var numberOfSections: Int {
        return count
    }

    subscript(index: IndexPath) -> Colleague {
        get {
            return self[index.section][index.row]
        }
        set {
            self[index.section].insert(newValue, at: index.row)
        }
    }

    func isEmptySection(_ section: Section) -> Bool {
        return self[section.rawValue].isEmpty
    }

    func titleForSection(_ section: Section) -> String? {
        return isEmptySection(section) ? nil : section.title
    }

    func numberOfColleagues(inSection section: Section) -> Int {
        return self[section.rawValue].count
    }

    func indexPathOfColleague(_ colleague: Colleague) -> IndexPath? {
        var row: Int?, section: Int?
        for (index, grp) in enumerated() {
            row = grp.index(of: colleague)

            if row != nil {
                section = index
                break
            }
        }

        if row == nil || section == nil {
            return nil
        }

        return IndexPath(row: row!, section: section!)
    }

    @discardableResult
    mutating func removeColleagueAtIndexPath(_ indexPath: IndexPath) -> Colleague {
        return self[indexPath.section].remove(at: indexPath.row)
    }
}
