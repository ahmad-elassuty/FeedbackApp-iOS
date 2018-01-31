//
//  JSONFileReader.swift
//  FeedbackAppFileStore
//
//  Created by Ahmed Elassuty on 1/30/18.
//  Copyright © 2018 Challenges. All rights reserved.
//

enum FileError: Error {
    case notFound
    case cannotBeParsedToJSON
}

class JSONFileReader {
    private init() {}

    static func loadResource(_ resource: String) throws -> [String: Any] {
        let bundle = Bundle(for: self.self)
        let filePath = bundle.path(forResource: "\(resource).json", ofType: nil)

        guard let path = filePath else {
            throw FileError.notFound
        }

        let url         = URL(fileURLWithPath: path)
        let data        = try Data(contentsOf: url, options: .mappedIfSafe)
        let jsonResult  = try JSONSerialization.jsonObject(
            with: data, options: .mutableLeaves
        )

        guard let JSON = jsonResult as? [String: Any] else {
            throw FileError.cannotBeParsedToJSON
        }

        return JSON
    }
}
