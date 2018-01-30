//
//  Result.swift
//  FeedbackAppDomain
//
//  Created by Ahmed Elassuty on 1/30/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

/**
*/
public struct Result<V, E: Error> {
    public let value: V?
    public let error: E?

    public var isSuccess: Bool {
        return value != nil
    }

    public var isError: Bool {
        return !isSuccess
    }

    private init(value: V? = nil, error: E? = nil) {
        self.value = value
        self.error = error
    }

    public init(value: V) {
        self.init(value: value, error: nil)
    }

    public init(error: E) {
        self.init(value: nil, error: error)
    }
}
