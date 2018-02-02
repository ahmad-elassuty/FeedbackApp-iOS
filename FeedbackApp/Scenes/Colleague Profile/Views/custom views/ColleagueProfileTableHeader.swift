//
//  ColleagueProfileTableHeader.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 2/1/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import UIKit

class ColleagueProfileTableHeader: UIView {
    @IBOutlet weak var contentView              : UIView!
    @IBOutlet weak var colleagueAvatarImageView : UIImageView!
    @IBOutlet weak var colleagueNameLabel       : UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
    }

    func setColleague(name: String, imageURL: URL?) {
        colleagueNameLabel.text = name
        colleagueAvatarImageView.kf.setImage(
            with: imageURL,
            placeholder: #imageLiteral(resourceName: "avatar"),
            options: [.transition(.fade(0.2))]
        )
    }
}

private extension ColleagueProfileTableHeader {
    var nibName: String {
        return String(describing: type(of: self))
    }

    func initializeView() {
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        addSubview(contentView)

        // Setup constraints
        contentView.translatesAutoresizingMaskIntoConstraints = false
        pinViewToEdges(contentView)

        // Prepare size
        bounds = CGRect(
            origin: .zero,
            size: systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        )
    }
}
