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
    func formatLastFeedbackLabel(_ colleague: ColleaguesList.Colleague) -> NSAttributedString? {
        guard let date = colleague.lastFeedbackDate,
            let dateString = colleague.lastFeedbackDateString else {
            return nil
        }

        let category = Theme.DateCategory(date: date)
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
