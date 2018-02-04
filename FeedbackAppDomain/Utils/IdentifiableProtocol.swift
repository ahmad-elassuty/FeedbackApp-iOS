//
//  IdentifiableProtocol.swift
//  FeedbackAppDomain
//
//  Created by Ahmed Elassuty on 1/30/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

/**
 A type that has identifier (id).
 */
public protocol Identifiable {
    associatedtype IdentifierType

    var id: IdentifierType { get }
}

extension Identifiable where Self: Equatable, IdentifierType: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
