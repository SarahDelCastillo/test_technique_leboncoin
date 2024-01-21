//
//  PlistHelper.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 21/01/2024.
//

import Foundation

enum PlistValues {
    private static let infoPlist = PlistHelper()
    static let itemsURL: String = infoPlist["API_ITEMS_URL"]
    static let categoriesURL: String = infoPlist["CATEGORIES_URL"]
}

struct PlistHelper {
    private let data: [String: Any]

    enum Values {
        case itemsURL, categoriesURL
    }

    init() {
        guard let document = Bundle.current.url(forResource: "Info", withExtension: "plist") else {
            fatalError("Could not fild Info.plist")
        }

        guard let data = try? NSDictionary(contentsOf: document, error: Void()) as? [String: Any] else {
            fatalError("Could not load data from Info.plist")
        }
        self.data = data
    }
    
    subscript<T>(key: String) -> T {
        guard let value = data[key] as? T else {
            fatalError("\(key) is not of type \(T.self)")
        }
        return value
    }
}
