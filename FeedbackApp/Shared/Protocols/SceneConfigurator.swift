//
//  SceneConfigurator.swift
//  FeedbackApp
//
//  Created by Ahmed Elassuty on 1/31/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

protocol SceneConfigurator {
    associatedtype Controller

    static func configure() -> Controller
}
