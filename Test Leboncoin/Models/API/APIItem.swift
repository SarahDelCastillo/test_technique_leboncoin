//
//  APIItem.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 20/01/2024.
//

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
