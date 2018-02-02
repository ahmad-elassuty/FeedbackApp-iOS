//
//  ColleagueProfileFeedbackTableViewCell.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 2/2/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import UIKit

class ColleagueProfileFeedbackTableViewCell: UITableViewCell {
    @IBOutlet weak var feedbackLabel: UILabel!

    func prepareForUse(feedback: ColleagueProfile.Feedback) {
        feedbackLabel.attributedText = formatFeedbackLabel(feedback)
    }
}

extension ColleagueProfileFeedbackTableViewCell {
    func formatFeedbackLabel(_ feedback: ColleagueProfile.Feedback) -> NSAttributedString? {
        let fontSize = feedbackLabel.font.pointSize
        let font: UIFont = .systemFont(ofSize: fontSize, weight: .medium)

        // Prepare text attributes
        let dateAttributes: [NSAttributedStringKey: AnyObject] = [
            .foregroundColor: feedback.dateCategory.color,
            .font: font
        ]

        // Prepare attributed strings
        let staticTextAttributedString = NSAttributedString(
            string: "Feedback sent: ",
            attributes: nil
        )

        let dateAttributedString = NSAttributedString(
            string: feedback.dateString,
            attributes: dateAttributes
        )

        // Combine resuts
        let mutableString = NSMutableAttributedString()
        mutableString.append(staticTextAttributedString)
        mutableString.append(dateAttributedString)

        return mutableString
    }
}
