//
//  APIItem.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 20/01/2024.
//

import Foundation

struct APIItem: Decodable {
    var id: Int
    var categoryId: Int
    var title: String
    var description: String
    var price: Double
    var imagesUrl: [String: String]
    var creationDate: String
    var isUrgent: Bool
}

extension APIItem {
    var creationDateExtracted: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: creationDate)
    }
}
