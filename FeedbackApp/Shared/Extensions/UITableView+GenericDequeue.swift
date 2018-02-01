//
//  UITableView+GenericDequeue.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T>(indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }

    func register(_ klass: AnyClass, identifier: String? = nil) {
        let nibName = String(describing: klass.self)
        let identifier = identifier ?? nibName
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: identifier)
    }
}
