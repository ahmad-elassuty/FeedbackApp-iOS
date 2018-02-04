//
//  EmptyFeedbacksView.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 2/4/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import UIKit

class EmptyFeedbacksView: UIView, Nibable {
    @IBOutlet weak var contentView  : UIView!
    @IBOutlet weak var titleLabel   : UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
    }

    func setData(colleague: ColleagueProfile.Colleague) {
        titleLabel.text = "Leave \(colleague.name) your feedback"
    }
}

private extension EmptyFeedbacksView {
    func initializeView() {
        Bundle.main.loadNibNamed(defaultNibName, owner: self, options: nil)
        addSubview(contentView)

        // Setup constraints
        contentView.translatesAutoresizingMaskIntoConstraints = false
        pinViewToEdges(contentView)
    }
}
