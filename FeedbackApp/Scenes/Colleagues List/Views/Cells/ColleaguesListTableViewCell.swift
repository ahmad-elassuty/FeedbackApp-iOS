//
//  ColleaguesListTableViewCell.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import UIKit
import FeedbackAppDomain
import Kingfisher

final class ColleaguesListTableViewCell: UITableViewCell {
    @IBOutlet weak var userImageView        : UIImageView!
    @IBOutlet weak var userNameLabel        : UILabel!
    @IBOutlet weak var feedbackButton       : UIButton!
    @IBOutlet weak var lastFeedbackDateLabel: UILabel!

    var colleague: ColleaguesList.Colleague?
    var giveColleagueFeedbackTapped: ((User.IdentifierType) -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()

        userImageView.roundCorners()
        feedbackButton.roundCorners(withRadius: 5)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        lastFeedbackDateLabel.isHidden = false
    }

    func prepareForUse(colleague: ColleaguesList.Colleague) {
        self.colleague                          = colleague

        userImageView.kf.setImage(
            with: colleague.avatarURL,
            placeholder: #imageLiteral(resourceName: "avatar"),
            options: [.transition(.fade(0.2))]
        )

        userNameLabel.text                      = colleague.name
        lastFeedbackDateLabel.attributedText    = formatLastFeedbackLabel(colleague)
    }

    @IBAction func giveFeedbackTapped(_ button: UIButton) {
        guard let colleague = colleague else {
                return
        }

        giveColleagueFeedbackTapped?(colleague.id)
    }
}

private extension ColleaguesListTableViewCell {
    /**
     Represents different date groups to provide
     the visual properties of the input date
     */
    enum FeedbackDateCategory {
        case
        lessThanMonth,
        lessThanYear,
        moreThanYear

        var color: UIColor {
            switch self {
            case .lessThanMonth:
                return #colorLiteral(red: 0, green: 0.3921568627, blue: 0, alpha: 1)
            case .lessThanYear:
                return #colorLiteral(red: 0.9843137255, green: 0.6784313725, blue: 0.2549019608, alpha: 1)
            case .moreThanYear:
                return #colorLiteral(red: 0.7529411765, green: 0.2235294118, blue: 0.168627451, alpha: 1)
            }
        }

        init(date: Date) {
            let now = Date()
            let monthAgoInterval: TimeInterval = -30 * 24 * 60 * 60
            let monthAgo = now.addingTimeInterval(monthAgoInterval)
            let yearAgo = now.addingTimeInterval(12 * monthAgoInterval)
            
            switch date {
            case _ where date > monthAgo:
                self = .lessThanMonth
            case _ where date > yearAgo:
                self = .lessThanYear
            default:
                self = .moreThanYear
            }
        }
    }

    func formatLastFeedbackLabel(_ colleague: ColleaguesList.Colleague) -> NSAttributedString? {
        guard let date = colleague.lastFeedbackDate,
            let dateString = colleague.lastFeedbackDateString else {
            return nil
        }

        let category = FeedbackDateCategory(date: date)
        let fontSize = lastFeedbackDateLabel.font.pointSize
        let font: UIFont = .systemFont(ofSize: fontSize, weight: .medium)

        // Prepare text attributes
        let dateAttributes: [NSAttributedStringKey: AnyObject] = [
            .foregroundColor: category.color,
            .font: font
        ]

        // Prepare attributed strings
        let staticTextAttributedString = NSAttributedString(
            string: "Last feedback you sent: ",
            attributes: nil
        )
        let dateAttributedString = NSAttributedString(
            string: dateString,
            attributes: dateAttributes
        )

        // Combine resuts
        let mutableString = NSMutableAttributedString()
        mutableString.append(staticTextAttributedString)
        mutableString.append(dateAttributedString)

        return mutableString
    }
}
